#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

istioctl install \
--set profile=default \
--set meshConfig.outboundTrafficPolicy.mode=REGISTRY_ONLY \
-y

kubectl apply -f google.yaml
