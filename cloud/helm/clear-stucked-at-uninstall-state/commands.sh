#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# Use this to clear the helm installation stucked at `uninstall` state
# https://github.com/helm/helm-mapkubeapis
helm plugin install https://github.com/helm/helm-mapkubeapis

helm -n elastic mapkubeapis kibana
helm -n elastic uninstall kibana
# release "kibana" uninstalled
