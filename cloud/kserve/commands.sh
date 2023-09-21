#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

kind create cluster -n kserve

# I use the `quickstart` configuration
# https://kserve.github.io/website/0.11/get_started/#install-the-kserve-quickstart-environment
curl -s "https://raw.githubusercontent.com/kserve/kserve/release-0.11/hack/quick_install.sh" | bash

# patched minimal operator, to enable auto injection
kubectl apply -f istio-minimal-operator.yaml

# enable istio sidecar injection
kubectl label namespace default istio-injection=enabled --overwrite
kubectl label namespace knative-serving istio-injection=enabled --overwrite

# First inference service
# https://kserve.github.io/website/master/get_started/first_isvc/#run-your-first-inferenceservice
kubectl create namespace kserve-test
kubectl apply -f manifests/first-inference-service.yaml

kubectl -n istio-system port-forward svc/istio-ingressgateway 8080:80
curl -v -H "Host: sklearn-iris.default.example.com" -H "Content-Type: application/json" "http://localhost:8080/v1/models/sklearn-iris:predict" -d @./iris-input.json
# {"predictions":[1,1]}

# kiali dashboard
# quickstart conf embedded istio 1.17
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.17/samples/addons/prometheus.yaml
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.17/samples/addons/kiali.yaml
kubectl -n istio-system port-forward svc/kiali 20001:20001

kubectl apply -f manifests/auth-policy.yaml
source tokens.sh
curl -v -H "Authorization: Bearer $TOKEN" -H "Host: sklearn-iris.default.example.com" -H "Content-Type: application/json" "http://localhost:8080/v1/models/sklearn-iris:predict" -d @./iris-input.json
# {"predictions":[1,1]}
curl -v -H "Authorization: Bearer $TOKEN_DEADBEEF" -H "Host: sklearn-iris.default.example.com" -H "Content-Type: application/json" "http://localhost:8080/v1/models/sklearn-iris:predict" -d @./iris-input.json
# RBAC: access denied

# EXTRA: debug RBAC
istioctl proxy-config log istio-ingressgateway-6ddb58d5c5-bwzdm.istio-system --level rbac:trace,jwt:trace
istioctl proxy-config log sklearn-iris-predictor-00001-deployment-759bcdffcd-mc8l7.default --level rbac:trace,jwt:trace


#####################################################################
# From client-go
#####################################################################

kubectl delete -f manifests/auth-policy.yaml
go run client-go/main.go

# test with curl

# test https
kubectl apply -f manifests/test-gateway-https.yaml