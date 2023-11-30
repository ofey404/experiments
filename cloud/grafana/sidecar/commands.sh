#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

kind create cluster -n sidecar-playground
docker update --restart=no sidecar-playground-control-plane

kubectl apply -f grafana-sidecar.yaml

kubectl port-forward pod/grafana-sidecar 3000:3000
# username & password are both admin
