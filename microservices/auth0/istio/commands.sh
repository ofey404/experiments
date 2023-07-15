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

USER=user@bookinfo.com
MODER=mod@bookinfo.com
PASSWORD=t^L5RGtl^lC7

echo "## Create test user via dashboard"
echo "user: $USER"
echo "moder: $MODER"
echo "password: $PASSWORD"

# There can be three different outcomes based on the user requests:
#
# Requests with valid tokens are admitted into the cluster, and their claims are made available to policies (as we'll see later on in the article)
# Requests with invalid tokens are rejected
# Requests without tokens (or with tokens that don't match any issuer) are admitted into the cluster but lack the claims (thus those requests can be denied by policies due to lack of claims)
kubectl apply -f security/auth0-authn.yaml
kubectl apply -f security/app-credentials.yaml

# Then patch deployment
kubectl -n demo patch deployment productpage-v1 --patch "
spec:
  template:
    spec:
      containers:
      - name: productpage
        image: rinormaloku/productpage:istio-auth0
        envFrom:
        - secretRef:
            name: app-credentials
"

# login, then
# decode the token, to inspect the outcome
kubectl logs deploy/productpage-v1 | grep Bearer | tail -n 1 | \
    awk -F'Bearer ' '{print $2}' | \
    awk -F\\ '{print $1}'

# Visualize JWT on https://jwt.io/
#
# header:
# {
#   "alg": "RS256",
#   "typ": "JWT",
#   "kid": "CstMCrv4lxQuxZPfz_zy4"
# }
#
# payload
# {
#   "iss": "https://dev-15m7pbrhilpcom2k.us.auth0.com/",
#   "sub": "auth0|64b21aa8e0dbe84c1a330b50",
#   "aud": [
#     "https://bookinfo.io",
#     "https://dev-15m7pbrhilpcom2k.us.auth0.com/userinfo"
#   ],
#   "iat": 1689395128,
#   "exp": 1689481528,
#   "azp": "CexKuxiCnGXKyoGTBeVflUadFRuDNS2d",
#   "scope": "openid profile",
#   "permissions": [
#     "read:book-details"
#   ]
# }

kubectl apply -f security/policies/
