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
npm install @mozilla/readability jsdom @types/jsdom

# Modify package.json
# exclude jsdom package.
# "bundle": "esbuild src/index.ts --outdir=bundle --sourcemap --bundle --platform=node --target=node20.10.0 --external:jsdom",

# if you only want a simple run
npm run start
