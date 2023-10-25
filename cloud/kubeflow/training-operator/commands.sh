#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

kind create cluster -n training-operator
docker update --restart=no training-operator-control-plane

# apply the master branch
kubectl apply -k "github.com/kubeflow/training-operator/manifests/overlays/standalone"
kubectl apply -f pytorchjob-example.yaml
