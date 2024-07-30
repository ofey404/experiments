#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

go get -u github.com/wenlng/go-captcha/v2@latest
go get -u github.com/wenlng/go-captcha-assets@latest

# quickstart
# http://gocaptcha.wencodes.com/guide/
cd quickstart/
go run .
# >>>>>  {"0":{"index":0,"x":144,"y":11,"size":31,"width":35,"height":35,"text":"柿","shape":"","angle":328,"color":"#b4fed4","color2":"#780592"},"1":{"index":1,"x":63,"y":176,"size":28,"width":36,"height":32,"text":"谊","shape":"","angle":327,"color":"#fb88ff","color2":"#1f55c4"}}

# More to see
# https://github.com/wenlng/go-captcha-example/tree/v2


# install react
yarn add go-captcha-react
# or
npm install go-captcha-react
# or
pnpm install go-captcha-react