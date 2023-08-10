#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# NOTE: This would fail... Don't try those commands
kind create cluster --image kindest/node:v1.24.7
docker stop kind-control-plane
docker start kind-control-plane

# 1.13 installation guide
# https://istio.io/v1.13/docs/setup/getting-started/#download
curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.13.9 TARGET_ARCH=x86_64 sh -

export PATH=$PATH:$(pwd)/istio-1.13.9/bin

# Generate the demo profile
istioctl install --set profile=demo -y
kubectl label namespace default istio-injection=enabled

kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml

