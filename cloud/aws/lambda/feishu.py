# play with feishu

import requests


def main():
    # Set Feishu parameters
    data_app = {
        "app_id": "cli_a4915737377d500c",
        "app_secret": "sqOOqtWk6A4pJx8ugJE9gdMsisQC5Sn0",
    }
    chat_name = "[开发] 云训练平台"
    # Get token
    try:
        res = requests.post(
            "https://open.feishu.cn/open-apis/auth/v3/tenant_access_token/internal/",
            json=data_app,
        )
        if res.status_code == 200:
            res_json = res.json()
            access_token = res_json.get("tenant_access_token")
    except Exception as e:
        return {"error": e}
    headers = {
        "Authorization": "Bearer {}".format(access_token),
        "Content-Type": "application/json; charset=utf-8",
    }
    # 获取群列表
    params = {"page_size": 100, "page_token": ""}
    res = requests.get(
        "https://open.feishu.cn/open-apis/chat/v4/list",
        params=params,
        headers=headers,
    )
    # print(res.content)
    if res.status_code != 200:
        raise Exception("get group list failed")
    print(res.json()['data']['groups'])

    # send Message
    chat_id = res.json()['data']['groups'][0].get("chat_id")

    data = {"chat_id": chat_id, "msg_type": "text", "content": {"text": "test"}}
    try:
        response = requests.post(
            "https://open.feishu.cn/open-apis/message/v4/send/",
            headers=headers,
            json=data,
        )
        print(response)
        print(response.json())
    except Exception as e:
        return {"error": e}


if __name__ == "__main__":
    main()
