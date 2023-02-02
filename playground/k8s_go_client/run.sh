#!/usr/bin/env bash
# set -x             # for debug
set -o errexit
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

GOOS=linux go build -o ./app .

docker build --tag localhost:5001/in-cluster-example:0.0.1 .

docker push localhost:5001/in-cluster-example:0.0.1

# add view permission to default service account
kubectl create clusterrolebinding default-view --clusterrole=view --serviceaccount=default:default

kubectl run --rm -i demo --image=localhost:5001/in-cluster-example:0.0.1
