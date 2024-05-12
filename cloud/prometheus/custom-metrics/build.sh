#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# CHANGE THIS: If we move the script.
SERVICE_ROOT=$SCRIPT_DIR

cd "$SERVICE_ROOT"

mkdir -p ./bin
go build -o bin/service .

docker build -t prometheus-custom-metrics:latest .
kind load docker-image prometheus-custom-metrics:latest -n prometheus-custom-metrics
