#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# prepare test env: hellokv2
pushd ../4-go-zero-integration
    kubectl apply -f deploy/all.yaml
popd

#####################################################################
# Installation okteto
curl https://get.okteto.com -sSfL | sh