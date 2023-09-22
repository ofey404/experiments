#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

kind create cluster -n dex-istio

helm repo add dex https://charts.dexidp.io
helm upgrade --install dex dex/dex --values example-app/values.yaml

kubectl port-forward svc/dex 5556:5556
