#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# port assignment in ingress gateway
kind create cluster -n ssh-multiplex
docker update --restart=no ssh-multiplex-control-plane

istioctl install -f istio.yaml
