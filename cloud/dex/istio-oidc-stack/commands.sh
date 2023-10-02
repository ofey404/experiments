#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# This scrip follows the steps of this awesome article
# https://datastrophic.io/secure-kubeflow-ingress-and-authentication/

kind create cluster -n istio-dex-oauth2-proxy-stack
docker update --restart=no istio-dex-oauth2-proxy-stack-control-plane
