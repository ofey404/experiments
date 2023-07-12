#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

kind create cluster --image=kindest/node:v1.23.1

##############################################
# Stage 1: services work without istio
##############################################

# create service
kubectl create ns demo
kubectl label namespace demo istio-injection=enabled

kubectl config set-context $(kubectl config current-context) --namespace=demo
kubectl apply -f platform/kube/bookinfo.yaml

kubectl wait pods --for condition=Ready --timeout -1s --all
kubectl get pods

# verify it's working
kubectl port-forward svc/productpage 9080:9080

# teardown service
kubectl delete -f platform/kube/bookinfo.yaml

##############################################
# install istio
##############################################

curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.14.0 TARGET_ARCH=x86_64 sh -
istioctl install --set profile=demo -y
kubectl get pods -n istio-system

##############################################
# Stage 2: with istio
##############################################

kubectl apply -f platform/kube/bookinfo.yaml
kubectl wait pods --for condition=Ready --timeout -1s --all
kubectl get pods

# add gateway and virtual service
kubectl apply -f networking/bookinfo-gateway.yaml

# since kind don't assign external ip, we need to port-forward
# the svc/istio-ingressgateway
kubectl port-forward -n istio-system svc/istio-ingressgateway 8080:80

# verify it's working
# visit:
# http://localhost:8080/productpage
#
# this is not responding
# http://localhost:8080/

istioctl proxy-config all deploy/productpage-v1 -o json | \
  jq -r '.. |."secret"? | select(.name == "default")'

# get SPIFFE ID - Secure Production Identity Framework For Everyone
istioctl proxy-config all deploy/productpage-v1 -o json | \
  jq -r '.. |."secret"?' | \
  jq -r 'select(.name == "default")' | \
  jq -r '.tls_certificate.certificate_chain.inline_bytes' | \
  base64 -d - | step certificate inspect
