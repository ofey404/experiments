import os
import requests
from dataclasses import dataclass, field


@dataclass
class RequestInput:
    ...


@dataclass
class API:
    app_id: str = field(default_factory=lambda: os.environ.get("FEISHU_APP_ID"))
    secret: str = field(default_factory=lambda: os.environ.get("FEISHU_APP_SECRET"))

    def _get_token(self):
        res = requests.post(
            "https://open.feishu.cn/open-apis/auth/v3/tenant_access_token/internal/",
            json={
                "app_id": self.app_id,
                "app_secret": self.secret,
            },
        )
        if res.status_code == 200:
            res_json = res.json()
            access_token = res_json.get("tenant_access_token")
            return access_token

        raise Exception("failed to get token, response: {}".format(res.content))
