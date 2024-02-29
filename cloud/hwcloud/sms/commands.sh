#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# This directory contains example code for Huawei Cloud SMS service.
# From: 
# https://support.huaweicloud.com/devg-msgsms/sms_04_0017.html#section0
#
# SMS Service Homepage: https://support.huaweicloud.com/msgsms/index.html

source .env

go run .
# APP_KEY = ...
# APP_SECRET = ...
# APP_ADDRESS = ...
# SENDER = ...
# RECEIVER = ...
# TEMPLATE_ID = ...
# ## request header JSON
# Content-Type: application/x-www-form-urlencoded
# X-Sdk-Date: 20240228T081151Z
# Authorization: SDK-HMAC-SHA256 Access=3w6Czxxxxxxxxxxxxxxxxc8H, SignedHeaders=content-type;x-sdk-date, Signature=8f6xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx8bb
# ## response
# {"result":[{"total":1,"originTo":"+86138xxxxxxxx","createTime":"2024-02-28T08:11:56Z","from":"10693689xxxxxxxx203","smsMsgId":"072170bd-1630-4856-ad42-b361f7bc9aca_1409436677","countryId":"CN","status":"000000"}],"code":"000000","description":"Success"}
