#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

goctl rpc protoc protoc/greeter.proto \
  -I./ \
  --go_out=./greeter \
  --go-grpc_out=./greeter \
  --zrpc_out=./greeter
