#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

cd get_metadata/
  go run .
cd -

cd create_delete_crd/
  go run . -kubeconfig ~/.kube/config -f tensorboard.yaml
cd -
