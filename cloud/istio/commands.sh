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

# deploy to cluster
istioctl install --set profile=demo -y

# enable injection for namespace
kubectl label namespace default istio-injection=enabled

# port forward to localhost
kubectl port-forward svc/istio-ingressgateway -n istio-system 80:80

# restart istiod to take effect
kubectl rollout restart deployment/istiod -n istio-system

# dump and edit profile
istioctl profile dump demo > istio-based-on-demo.yaml
istioctl install -f istio-based-on-demo.yaml
