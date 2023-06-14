# https://github.com/volcengine/volc-openapi-demos/blob/775a553be3fcca1fe5cbbcdcd4ea8aee6d7839ea/signature/python/sign.py#L65
import typing
import datetime
import hashlib
import hmac
import os
from urllib.parse import quote
from dataclasses import dataclass, field
import requests


@dataclass
class RequestInput:
    method: str
    action: str
    date: typing.Any = field(default_factory=lambda: datetime.datetime.utcnow())
    query: dict = field(default_factory=lambda: {})
    header: dict = field(default_factory=lambda: {})
    body: typing.Any = None


@dataclass
class API:
    service: str
    version: str
    region: str
    host: str = "open.volcengineapi.com"
    content_type: str = "application/json"
    ak: str = field(default_factory=lambda: os.environ.get("VOLCENGINE_ACCESS_KEY"))
    sk: str = field(default_factory=lambda: os.environ.get("VOLCENGINE_SECRET_KEY"))
    verbose: bool = False

    def request(self, i: RequestInput):
        # 创建身份证明。其中的 Service 和 Region 字段是固定的。ak 和 sk 分别代表
        # AccessKeyID 和 SecretAccessKey。同时需要初始化签名结构体。一些签名计算时需要的属性也在这里处理。
        # 初始化身份证明结构体
        credential = {
            "access_key_id": self.ak,
            "secret_access_key": self.sk,
            "service": self.service,
            "region": self.region,
        }
        # 初始化签名结构体
        request_param = {
            "body": i.body,
            "host": self.host,
            "path": "/",
            "method": i.method,
            "content_type": self.content_type,
            "date": i.date,
            "query": {
                "Action": i.action,
                "Version": self.version,
                **i.query
            },
        }
        if i.body is None:
            request_param["body"] = ""

        # 接下来开始计算签名。在计算签名前，先准备好用于接收签算结果的 signResult 变量，并设置一些参数。
        # 初始化签名结果的结构体
        x_date = request_param["date"].strftime("%Y%m%dT%H%M%SZ")
        short_x_date = x_date[:8]
        x_content_sha256 = hash_sha256(request_param["body"])
        sign_result = {
            "Host": request_param["host"],
            "X-Content-Sha256": x_content_sha256,
            "X-Date": x_date,
            "Content-Type": request_param["content_type"],
        }

        # 计算 Signature 签名。
        signed_headers_str = ";".join(["content-type", "host", "x-content-sha256", "x-date"])
        # signed_headers_str = signed_headers_str + ";x-security-token"
        canonical_request_str = "\n".join([
            request_param["method"].upper(),
            request_param["path"],
            norm_query(request_param["query"]),
            "\n".join([
                "content-type:" + request_param["content_type"],
                "host:" + request_param["host"],
                "x-content-sha256:" + x_content_sha256,
                "x-date:" + x_date,
            ]),
            "",
            signed_headers_str,
            x_content_sha256,
        ])

        if self.verbose:
            # 打印正规化的请求用于调试比对
            print(canonical_request_str)

        hashed_canonical_request = hash_sha256(canonical_request_str)

        if self.verbose:
            # 打印hash值用于调试比对
            print(hashed_canonical_request)
        credential_scope = "/".join([short_x_date, credential["region"], credential["service"], "request"])
        string_to_sign = "\n".join(["HMAC-SHA256", x_date, credential_scope, hashed_canonical_request])

        if self.verbose:
            # 打印最终计算的签名字符串用于调试比对
            print(string_to_sign)

        k_date = hmac_sha256(credential["secret_access_key"].encode("utf-8"), short_x_date)
        k_region = hmac_sha256(k_date, credential["region"])
        k_service = hmac_sha256(k_region, credential["service"])
        k_signing = hmac_sha256(k_service, "request")
        signature = hmac_sha256(k_signing, string_to_sign).hex()

        sign_result["Authorization"] = "HMAC-SHA256 Credential={}, SignedHeaders={}, Signature={}".format(
            credential["access_key_id"] + "/" + credential_scope,
            signed_headers_str,
            signature,
        )
        header = {**i.header, **sign_result}

        # header = {**header, **{"X-Security-Token": SessionToken}}
        # 将 Signature 签名写入 HTTP Header 中，并发送 HTTP 请求。
        r = requests.request(
            method=i.method,
            url="https://{}{}".format(request_param["host"], request_param["path"]),
            headers=header,
            params=request_param["query"],
            data=request_param["body"],
        )
        return r


def norm_query(params):
    query = ""
    for key in sorted(params.keys()):
        if type(params[key]) == list:
            for k in params[key]:
                query = (query + quote(key, safe="-_.~") + "=" + quote(k, safe="-_.~") + "&")
        else:
            query = (query + quote(key, safe="-_.~") + "=" + quote(params[key], safe="-_.~") + "&")
    query = query[:-1]
    return query.replace("+", "%20")


# sha256 非对称加密
def hmac_sha256(key: bytes, content: str):
    return hmac.new(key, content.encode("utf-8"), hashlib.sha256).digest()


# sha256 hash算法
def hash_sha256(content: str):
    return hashlib.sha256(content.encode("utf-8")).hexdigest()
