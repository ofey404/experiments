#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

kind create cluster -n jupyterhub
docker update --restart=no jupyterhub-control-plane

helm repo add jupyterhub https://hub.jupyter.org/helm-chart/
helm repo update

# check the chart
helm pull jupyterhub/jupyterhub --version 3.1.0 --untar

# install it
helm upgrade --version 3.1.0 --install jupyterhub jupyterhub/jupyterhub
