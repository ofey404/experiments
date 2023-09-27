#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

# go code
protoc --go_out=./go/helloworld --go_opt=paths=source_relative \
    --go-grpc_out=./go/helloworld --go-grpc_opt=paths=source_relative \
    helloworld.proto

# python code
python -m grpc_tools.protoc \
       -I. \
       --python_out=./python \
       --pyi_out=./python \
       --grpc_python_out=./python \
       ./helloworld.proto