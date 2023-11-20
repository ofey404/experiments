#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# CHANGE THIS: If we move the script.
SERVICE_ROOT=$SCRIPT_DIR

cd "$SERVICE_ROOT"

goctl api go -api api/hellokv.api -dir .
goctl rpc protoc pb/hellokv.proto \
  --go_out="$(pwd)" \
  --go-grpc_out="$(pwd)" \
  --zrpc_out="$(pwd)"
