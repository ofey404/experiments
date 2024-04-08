#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# https://stackoverflow.com/questions/30109787/internationalization-of-api-error-messages-on-front-end-or-back-end
# 
# Plan 1: Backend is language agnostic, send error code.
#         The cumbersome part is the format (%s), these data should be packed alongside the error code.
#         So, this directory is created to make sure we can do this.
#
#         Backend format: user %s not found
#         HTTP error body: { code: 10001, message: "user test_user_1 not found", values: ["test_user_1"]}
#         Frontend format:
#         - user %s not found
#         - 用户 %s 不存在
# 
# Plan 2: Backend has locale.
#         Benefit: Can add an error without changing the frontend.
#         But in general it's a worse idea.

npx create-react-app frontend --template typescript
