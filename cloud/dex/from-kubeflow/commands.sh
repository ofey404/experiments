#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# currently it's 1.27.3
kind create cluster -n from-kubeflow
docker update --restart=no from-kubeflow-control-plane

kubectl apply -k kustomization
kubectl apply -f nginx-test-application.yaml
kubectl apply -f virtualservice.yaml # Or the /authservice endpoint won't be exposed.

kubectl port-forward svc/istio-ingressgateway -n istio-system 8080:80

curl localhost:8080/nginx

kubectl port-forward svc/nginx -n nginx 8080:80


