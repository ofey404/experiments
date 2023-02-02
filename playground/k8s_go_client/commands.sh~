#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

kind create cluster

kubectl cluster-info --context kind-kind

GOOS=linux go build -o ./app .

./kind_with_registry.sh

# test kind local registry
docker pull gcr.io/google-samples/hello-app:1.0
docker tag gcr.io/google-samples/hello-app:1.0 localhost:5001/hello-app:1.0
docker push localhost:5001/hello-app:1.0