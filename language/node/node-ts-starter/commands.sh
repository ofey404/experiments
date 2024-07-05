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

# compile, run and watch
npm run dev

# if you only want a simple run
npm run start

# the test all we loved
npm run test