#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# debug RBAC
istioctl proxy-config log istio-ingressgateway-79bb75ddbb-xpqw6.istio-system --level rbac:trace,jwt:trace
