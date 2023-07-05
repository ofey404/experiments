#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

kubectl apply -f network-testing-service.yaml

kubectl port-forward svc/network-testing-service 8080:80

kubectl apply -f ingress.yaml

kubectl delete -f ingress.yaml -f network-testing-service.yaml
