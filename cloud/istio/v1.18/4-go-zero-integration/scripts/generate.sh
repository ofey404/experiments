#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

PROJECT_ROOT="$SCRIPT_DIR"/..

cd $PROJECT_ROOT

pushd cmd/api/ > /dev/null
  echo "Generating API in $(pwd)"
  goctl api go -api desc/hellokv2.api -dir .
popd > /dev/null

pushd cmd/rpc/ > /dev/null
  echo "Generating RPC in $(pwd)"
  goctl rpc protoc pb/hellokv2.proto \
    --go_out="$(pwd)" \
    --go-grpc_out="$(pwd)" \
    --zrpc_out="$(pwd)"
popd > /dev/null

pushd model/ > /dev/null
  echo "Generating mongo in $(pwd)"
  goctl model mongo -t HelloKv2 -d .
popd > /dev/null
