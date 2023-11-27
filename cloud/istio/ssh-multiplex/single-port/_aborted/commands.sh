#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# single-port ssh multiplex in kubernetes (Aborted)
kubectl apply -f single-port-multiplex.yaml
ssh linuxserver.io@ssh-multiplex-0.ssh-multiplex.default.svc.cluster.local -p 2222
ssh linuxserver.io@localhost -p 31400
