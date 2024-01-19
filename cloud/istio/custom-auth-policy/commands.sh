#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# We need to implement a JWT blocklist for signout feature.
# That's why we need CUSTOM auth policy.
#
# Reference: https://istio.io/latest/docs/tasks/security/authorization/authz-custom/

kind create cluster -n istio-custom-auth-policy
docker update --restart=no istio-custom-auth-policy-control-plane

# The external authorizer should implement the ext_authz API.
# https://www.envoyproxy.io/docs/envoy/latest/api-v3/extensions/filters/http/ext_authz/v3/ext_authz.proto
# 
# Official Example:
# https://github.com/istio/istio/blob/56314992f1174196e1e74a5339eff1f443f517cd/samples/extauthz/cmd/extauthz/main.go#L260-L280

go run .
# Starting server on port 8000
# 2024/01/19 14:11:06 [HTTP][denied]: GET localhost:8000/, headers: map[Accept:[*/*] User-Agent:[curl/7.81.0]], body: []
# 2024/01/19 14:11:20 [HTTP][allowed]: GET localhost:8000/, headers: map[Accept:[*/*] User-Agent:[curl/7.81.0] X-Ext-Authz:[allow]], body: []

curl localhost:8000
# denied by ext_authz for not found header `x-ext-authz: allow` in the request

curl -v -H 'x-ext-authz: allow' localhost:8000
# > x-ext-authz: allow
# < HTTP/1.1 200 OK
# < X-Ext-Authz-Additional-Header-Override:
# < X-Ext-Authz-Check-Received: GET localhost:8000/, headers: map[Accept:[*/*] User-Agent:[curl/7.81.0] X-Ext-Authz:[allow]], body: []
# < X-Ext-Authz-Check-Result: allowed

./build.sh
# => => naming to docker.io/library/ext_authz_example:latest
kind load docker-image docker.io/library/ext_authz_example:latest -n istio-custom-auth-policy

# install istio
istioctl install -f manifests/istio-with-extensionprovider.yaml
kubectl label namespace default istio-injection=enabled

# create authz
kubectl apply -f manifests/ext-authz.yaml

# auth policy
kubectl apply -f ../../../snippets/request-visualizer.yaml
kubectl apply -f manifests/custom-auth-policy.yaml

# visit
kubectl port-forward svc/istio-ingressgateway 8000:80 -n istio-system

# repeat it again
curl localhost:8000
# denied by ext_authz for not found header `x-ext-authz: allow` in the request

curl -v -H 'x-ext-authz: allow' localhost:8000
# < HTTP/1.1 200 OK
# GET request for /

# In request-visualizer log:
#
# x-ext-authz: allow
