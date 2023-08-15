#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

PROJECT_ROOT="$SCRIPT_DIR"/..

cd $PROJECT_ROOT

kind load docker-image hellokv2-api:latest
kind load docker-image hellokv2-rpc:latest
