import requests

MODE_UP = "up"
MODE_DOWN = "down"


class Report:

    def __init__(self, mode):
        self.mode = mode
        self.succeeded = []
        self.errors = {}

    def success(self, name):
        self.succeeded.append(name)

    def error(self, name, error):
        self.errors[name] = error


class MessagePusher:

    def __init__(self, app_id, app_secret):
        self.app_id = app_id
        self.app_secret = app_secret
        self.token = self._get_token()

    def _get_token(self):
        data_app = {
            "app_id": self.app_id,
            "app_secret": self.app_secret,
        }
        res = requests.post(
            "https://open.feishu.cn/open-apis/auth/v3/tenant_access_token/internal/",
            json=data_app,
        )
        if res.status_code == 200:
            res_json = res.json()
            access_token = res_json.get("tenant_access_token")
            return access_token

        raise Exception("failed to get token, response: {}".format(res.content))

    def _get_all_chatid(self):
        # FIXME: handle pagination
        params = {"page_size": 100, "page_token": ""}
        resp = requests.get(
            "https://open.feishu.cn/open-apis/chat/v4/list",
            params=params,
            headers=self._headers(),
        )
        if resp.status_code != 200:
            raise Exception("get group list failed, response: {}".format(resp.content))

        groups = resp.json()["data"]["groups"]
        return [g.get("chat_id") for g in groups]

    def _headers(self):
        return {
            "Authorization": "Bearer {}".format(self.token),
            "Content-Type": "application/json; charset=utf-8",
        }

    def push_string(self, str):
        for chat_id in self._get_all_chatid():
            data = {
                "chat_id": chat_id,
                "msg_type": "text",
                "content": {
                    "text": "{}".format(str)
                },
            }
            resp = requests.post(
                "https://open.feishu.cn/open-apis/message/v4/send/",
                headers=self._headers(),
                json=data,
            )
            if resp.status_code != 200:
                raise Exception("failed to send message, response: {}".format(resp.content))

    def push(self, state):
        if state.mode == MODE_UP:
            title = "Scaling up clusters on buissiness hours."
        elif state.mode == MODE_DOWN:
            title = "Scaling down clusters on non-buissiness hours."
        else:
            raise Exception("Unknown mode: {}".format(state.mode))

        succeeded = "\n".join(["- {}".format(name) for name in state.succeeded])
        failed = "\n".join(["- {}: {}".format(name, error) for name, error in state.errors.items()])

        if len(state.succeeded) == 0 and len(state.errors) == 0:
            self.push_string("No cluster to scale, have a nice day")
        elif len(state.errors) == 0:
            self.push_string(f"{title}\n{succeeded}\n")
        elif len(state.succeeded) == 0:
            self.push_string(f"[ERROR] {title}\nerror:{failed}\n")
        else:
            self.push_string(f"[ERROR] {title}\nsucceeded:\n{succeeded}\nerror:\n{failed}")
