#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

##############################################
# Don't run. This file is a note for commands.
##############################################

kubectl apply -f torch.yaml

# kubectl get pods --all-namespaces
kubectl -n kubeflow get pods
kubectl delete -f torch.yaml
