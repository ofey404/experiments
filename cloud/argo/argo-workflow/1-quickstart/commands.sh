#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# Argo: Open source tools for Kubernetes to run workflows, manage clusters, and do GitOps right.
# https://argoproj.github.io/

# Argo Workflows:
# https://argo-workflows.readthedocs.io/en/latest/

kind create cluster -n argo-workflow
docker update --restart=no argo-workflow-control-plane

# install
ARGO_WORKFLOWS_VERSION="v3.5.10"
wget https://github.com/argoproj/argo-workflows/releases/download/${ARGO_WORKFLOWS_VERSION}/quick-start-minimal.yaml

kubectl create namespace argo
kubectl apply -f quick-start-minimal.yaml 
# https://argo-workflows.readthedocs.io/en/latest/quick-start/
