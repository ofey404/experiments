#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

kind create cluster --image kindest/node:v1.27.3
docker stop kind-control-plane
docker start kind-control-plane

istioctl install --set profile=default -y

kubectl apply -f ../4-go-zero-integration/deploy/network-tester.yaml
# curl google ok.
# external traffic are all allowed.

../4-go-zero-integration/scripts/load_to_kind.sh
helm install mongodb oci://registry-1.docker.io/bitnamicharts/mongodb \
--set auth.rootPassword=RootPassword
kubectl apply -f ../5-local-development/1-telepresence/all-with-tele-patch.yaml
