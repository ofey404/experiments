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
