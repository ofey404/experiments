# https://blog.51cto.com/wutengfei/4361109

# Note that the file name must be lambda_function.py
# cat lambda_function.py

# -*- coding: UTF-8 -*-
# author: tengfei.wu
# date: 20211028
# version: V1

import requests
import json
import os


def lambda_handler(event, context):
    # Set Feishu parameters
    data_app = {"app_id": "your-id", "app_secret": "your-secret"}
    chat_name = "your Feishu alarm group name"
    # Get token
    try:
        res = requests.post("https://open.feishu.cn/open-apis/auth/v3/tenant_access_token/internal/", json=data_app)
        if res.status_code == 200:
            res_json = res.json()
            access_token = res_json.get("tenant_access_token")
            access_token = access_token
    except Exception as e:
        return {"error": e}
    headers = {"Authorization": "Bearer {}".format(access_token), "Content-Type": "application/json; charset=utf-8"}
    # 获取群列表
    params = {"page_size": 100, "page_token": ""}
    try:
        res = requests.get("https://open.feishu.cn/open-apis/chat/v4/list", params=params, headers=headers)
        if res.status_code == 200:
            res_json = res.json()
            data = res_json.get("data")
            groups = data.get("groups")
            for i in groups:
                if i.get("name") == chat_name:
                    group = i
    except Exception as e:
        return {"error": e}
    # send Message
    chat_id = group.get("chat_id")

    message = event['Records'][0]['Sns']
    Timestamp = message['Timestamp']
    Subject = message['Subject']
    sns_message = json.loads(message['Message'])
    region = message['TopicArn'].split(':')[-3]
    NewStateReason = json.loads(event['Records'][0]['Sns']['Message'])['NewStateReason']

    if "ALARM" in Subject:
        title = '[AI生产环境] 警报！!'
    elif "OK" in Subject:
        title = '[AI生产环境] 故障恢复！'
    else:
        title = '[AI生产环境] 警报状态异常'

    content = title \
              + "\n> **详情信息**" \
              + "\n> **时间**: " + Timestamp \
              + "\n> **内容**: " + Subject \
              + "\n> **状态**: {old} => {new}".format(old=sns_message['OldStateValue'], new=sns_message['NewStateValue']) \
              + "\n> " \
              + "\n> **AWS区域**: " + sns_message['Region'] \
              + "\n> **监控资源对象**: " + sns_message['Trigger']['Namespace'] \
              + "\n> **监控指标**: " + sns_message['Trigger']['MetricName'] \
              + "\n> " \
              + "\n> **报警名称**: " + sns_message['AlarmName'] \
              + "\n> **报警创建方式**: " + sns_message['AlarmDescription'] \
              + "\n> " \
              + "\n> **报警细节**: " + NewStateReason

    data = {"chat_id": chat_id, "msg_type": 'text', "content": {'text': content}}
    print(data)
    try:
        response = requests.post("https://open.feishu.cn/open-apis/message/v4/send/", headers=headers, json=data)
        print(response)
        print(response.json())
    except Exception as e:
        return {"error": e}
