#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"/protoc

protoc --go_out=../common --go_opt=paths=source_relative common.proto

goctl rpc protoc greeter.proto \
  --go_opt=paths=source_relative \
  --go_out=../greeter/greeter \
  --go-grpc_opt=paths=source_relative \
  --go-grpc_out=../greeter/greeter \
  --zrpc_out=../greeter

goctl rpc protoc greeter2.proto \
  --go_opt=paths=source_relative \
  --go_out=../greeter2/greeter2 \
  --go-grpc_opt=paths=source_relative \
  --go-grpc_out=../greeter2/greeter2 \
  --zrpc_out=../greeter2
