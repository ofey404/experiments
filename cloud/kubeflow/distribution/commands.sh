#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

kind create cluster -n kubeflow
docker update --restart=no kubeflow-control-plane

git clone git@github.com:kubeflow/manifests.git kubeflow-manifests
cd kubeflow-manifests

while ! kubectl kustomize example | awk '!/well-defined/' | kubectl apply -f -; do echo "Retrying to apply resources"; sleep 10; done

kubectl port-forward svc/istio-ingressgateway -n istio-system 8080:80

# default credential
# user@example.com
# 12341234
