#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# [Kubernetes Port Forwarding - Error listen tcp4 127.0.0.1:88: bind: permission denied](https://stackoverflow.com/questions/53775328/kubernetes-port-forwarding-error-listen-tcp4-127-0-0-188-bind-permission-de)
sudo setcap CAP_NET_BIND_SERVICE=+eip /usr/local/bin/kubectl
sudo setcap CAP_NET_BIND_SERVICE=+eip /usr/local/bin/k9s
