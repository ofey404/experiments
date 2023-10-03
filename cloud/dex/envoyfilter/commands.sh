#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# THIS SCRIPT IS BROKEN

# istio 1.11 supports 1.19, 1.20, 1.21, 1.22
# https://istio.io/v1.11/docs/releases/supported-releases/
kind create cluster -n dex-envoyfilter --image kindest/node:v1.22.17
docker update --restart=no dex-envoyfilter-control-plane
