#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

#####################################################################
# EDIT: THIS METHOD IS NOT MATURE. USE istioctl INSTEAD
#####################################################################
#
# See:
# Install with Helm | Istio
# https://istio.io/latest/docs/setup/install/helm/

# uninstall istio
PATH=$PATH:$(pwd)/../istio-1.18.2/bin
istioctl uninstall --purge

helm repo add istio https://istio-release.storage.googleapis.com/charts
helm repo update

# 1. CRD
helm install istio-base istio/base -n istio-system --set defaultRevision=default
helm show values istio/base

# 2. Discovery
helm install istiod istio/istiod -n istio-system --wait
helm show values istio/istiod

helm status istiod -n istio-system

# 3. (optional) Ingress gateway
# https://istio.io/latest/docs/setup/additional-setup/gateway/
kubectl create namespace istio-ingress
helm install istio-ingress istio/gateway -n istio-system
helm show values istio/gateway
# https://www.lisenet.com/2023/kiali-does-not-see-istio-ingressgateway-installed-in-separate-kubernetes-namespace/
# Use this to clear the helm installation stucked at `uninstall` state
# https://github.com/helm/helm-mapkubeapis
helm plugin install https://github.com/helm/helm-mapkubeapis

# 4. set up a service chain
# mongodb
helm install mongodb oci://registry-1.docker.io/bitnamicharts/mongodb \
--set auth.rootPassword=RootPassword
kubectl apply -f ../5-local-development/1-telepresence/all-with-tele-patch.yaml 

telepresence helm install
telepresence connect

curl -d '{"key": "hello"}' \
-H "Content-Type: application/json" \
-X POST hellokv-api.default/getkey

curl -d '{"key": "hello", "value": "world"}' \
-H "Content-Type: application/json" \
-X POST hellokv-api.default/setkey

# 5. test istio specific features
kubectl apply -f gateway.yaml

# istio-ingress.istio-ingress is the gateway
curl -d '{"key": "hello"}' \
-H "Content-Type: application/json" \
-X POST istio-ingress.istio-system/getkey
# {"value":"world"}
