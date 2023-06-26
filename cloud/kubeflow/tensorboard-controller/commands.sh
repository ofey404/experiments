#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

kubectl apply -k kustomization/
kubectl apply -f example/tensorboard.yaml 
kubectl -n tensorboard cp example/Jun26_09-37-02_user/ tensorboard/my-tensorboard-hostpath-7dc875687b-tcnpl:/tensorboard_logs/Jun26_09-37-02_user/

kubectl -n tensorboard port-forward svc/my-tensorboard-hostpath 8080:80
cmd.exe /c "start microsoft-edge:https://localhost:8080"
