#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

kind create cluster -n expose-node-port --config kind-config.yaml
docker update --restart=no expose-node-port-control-plane

# get cluster info
docker inspect expose-node-port-control-plane
# "Ports": {
#     "30080/tcp": [
#         {
#             "HostIp": "0.0.0.0",
#             "HostPort": "30080"
#         }
#     ],
#     "30081/tcp": [
#         {
#             "HostIp": "0.0.0.0",
#             "HostPort": "30081"
#         }
#     ],
# ...

kubectl apply -f nginx.yaml
curl localhost:30080
# <p><em>Thank you for using nginx.</em></p>
