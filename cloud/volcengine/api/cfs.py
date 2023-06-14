from sign import API, RequestInput
import json
from dataclasses import dataclass


def list_fs(api):
    """Doc: https://www.volcengine.com/docs/6720/108362"""
    resp = api.request(i=RequestInput(
        method="Get",
        action="ListFs",
    ))
    print(f"Resp: {resp.json()}")
    return resp


@dataclass
class CreateFsInput:
    fs_name: str

    # object storage
    tos_bucket: str

    # network
    vpc_id: str
    subnet_id: str
    security_group_id: str

    # optional fields
    zone_id: str = "cn-beijing-b"
    cache_plan: str = "T2"
    cache_capacity_tib: int = 10


def create_fs(api: API, i: CreateFsInput):
    """Doc: https://www.volcengine.com/docs/6720/108311"""
    resp = api.request(i=RequestInput(
        method="POST",
        action="CreateFs",
        body=json.dumps({
            "FsName": i.fs_name,
            "ChargeType": "POST_CHARGE",
            "BillingType": "MONTHLY",
            "ZoneId": i.zone_id,
            "CachePlan": i.cache_plan,
            "CacheCapacityTiB": i.cache_capacity_tib,
            "Mode": "ACC_MODE",
            "TosBucket": i.tos_bucket,
            "VpcId": i.vpc_id,
            "SubnetId": i.subnet_id,
            "SecurityGroupId": i.security_group_id,
            "VpcRouteEnabled": True,
        }),
    ))

    print(f"Resp: {resp.json()}")
    return resp


def delete_fs(api: API):
    """https://www.volcengine.com/docs/6720/108365"""
    resp = api.request(i=RequestInput(
        method="POST",
        action="DeleteFs",
        body=json.dumps({"FsName": "disposable-230614"}),
    ))

    print(f"Resp: {resp.json()}")
    return resp


def main():
    api = API(
        region="cn-beijing",
        service="cfs",
        version="2022-02-02",
    )

    # create_fs(api, i=CreateFsInput())

    # resp = list_fs(api)
    # print(resp.json()["Result"]["Items"][0]["Status"])

    delete_fs(api)


if __name__ == "__main__":
    main()
