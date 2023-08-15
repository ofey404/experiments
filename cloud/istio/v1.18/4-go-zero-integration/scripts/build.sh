#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

PROJECT_ROOT="$SCRIPT_DIR"/..

cd $PROJECT_ROOT
TAG_API=hellokv2-api:latest
TAG_RPC=hellokv2-rpc:latest

pushd cmd/api/ > /dev/null
    echo "Building image: $TAG_API"
    mkdir -p ./bin
    go build -o bin/service .
    docker build -t $TAG_API .
popd > /dev/null

pushd cmd/rpc/ > /dev/null
    echo "Building image: $TAG_RPC"
    mkdir -p ./bin
    go build -o bin/service .
    docker build -t $TAG_RPC .
popd > /dev/null
