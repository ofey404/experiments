#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# currently it's 1.27.3
kind create cluster -n envoyfilter
docker update --restart=no envoyfilter-control-plane

istioctl install --set profile=demo -y
# kubectl apply -k kustomization
kubectl apply -f request-visualizer.yaml

kubectl port-forward svc/istio-ingressgateway -n istio-system 8080:80

# request without envoyfilter
curl localhost:8080/request-visualizer
# app INFO:root:Starting httpd... app app INFO:root:GET request, app Path: / app
# Headers: app host: localhost:8080 app user-agent: curl/7.81.0 app accept: */*
# app x-forwarded-for: 10.244.0.5 app x-forwarded-proto: http app x-request-id:
# 1df96067-ee9e-4a14-b51d-a8623671ec41 app x-forwarded-host: localhost:8080 app
# x-envoy-attempt-count: 1 app x-envoy-original-path: /request-visualizer app
# x-envoy-internal: true app x-forwarded-client-cert:
# By=spiffe://cluster.local/ns/request-visualizer/sa/default;Hash=8324a6a24332c7392a7d43d2df1a0920ad2ad8f645070c3dfce6e72b8c467788;Subject="";URI=spiffe://cluster.local/ns/istio-system/sa/istio-ingressgateway-service-account
# app app app app 127.0.0.6 - - [03/Oct/2023 09:04:23] "GET / HTTP/1.1" 200 -

kubectl apply -f add-custom-header.yaml
curl localhost:8080/request-visualizer
# ...
# app my-custom-header: it works!
kubectl delete -f add-custom-header.yaml

kubectl apply -f check-user1.yaml
curl localhost:8080/request-visualizer
# Access denied
curl localhost:8080/request-visualizer -H "user: user1"
# GET request for /
