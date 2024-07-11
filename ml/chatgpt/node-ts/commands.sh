#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# starter:
# https://github.com/xddq/nodejs-typescript-modern-starter

npm install

# if you only want a simple run
npm run start
# read a environment variable
MY_ENV=my-value npm run start

# compile, run and watch
npm run dev

# the test all we loved
npm run test