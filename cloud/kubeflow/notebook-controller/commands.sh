#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

kind create cluster -n notebook-controller
docker update --restart=no notebook-controller-control-plane

istioctl install --set profile=demo -y
kubectl label namespace default istio-injection=enabled

# create controller
kubectl apply -k kustomization/

kubectl apply -f gateway.yaml
kubectl apply -f notebook-sample.yaml
