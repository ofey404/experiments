#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# set up an experiment environment
kind create cluster -n mongo
docker update --restart=no mongo-control-plane

helm repo add bitnami https://charts.bitnami.com/bitnami
# root:password
helm install mongodb bitnami/mongodb --version 13.9.4 --values values.yaml

# use 27027 to avoid conflict with local mongodb
while true; do kubectl port-forward svc/mongodb 27027:27017; done
