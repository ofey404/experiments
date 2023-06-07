#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# for shared node backend of all languages
npm install -g aws-cdk

cdk --version
# 2.64.0 (build fb67c77)

# get ACCOUNT-NUMBER
aws sts get-caller-identity

cdk bootstrap aws://ACCOUNT-NUMBER/REGION

cdk init app --language go
# rm go.mod
