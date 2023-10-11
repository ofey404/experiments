#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# Following this guide:
# https://www.keycloak.org/getting-started/getting-started-kube

# 1.27.3
kind create cluster -n keycloak-prod-deploy
docker update --restart=no keycloak-prod-deploy-control-plane

# https://artifacthub.io/packages/helm/bitnami/keycloak/15.1.6
helm install keycloak bitnami/keycloak --version 15.1.6 --values values/keycloak.yaml

kubectl port-forward svc/keycloak 80:80

# https://artifacthub.io/packages/helm/oauth2-proxy/oauth2-proxy
helm repo add oauth2-proxy https://oauth2-proxy.github.io/manifests
helm install oauth2-proxy oauth2-proxy/oauth2-proxy --version 6.17.1 --values values/oauth2-proxy.yaml

istioctl install -f istio-profile.yaml
kubectl apply -f all-virtualservices.yaml
kubectl apply -f nginx-test-application.yaml
kubectl apply -f auth-policy.yaml 

kubectl port-forward svc/istio-ingressgateway -n istio-system 80:80
