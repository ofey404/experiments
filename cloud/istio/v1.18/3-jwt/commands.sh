#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# Doc: Authentication | Istio
# https://istio.io/latest/docs/tasks/security/authentication/

# use image from microservice/jwt
docker run -it --rm test-pyjwt:latest
#  * Running on http://127.0.0.1:5000

# restart kind cluster
docker stop kind-control-plane
docker start kind-control-plane
kubectl config use-context kind-kind

# Werid behavior here.
# See:
# cloud/istio/v1.18/1-virtual-service/commands.sh
kind load docker-image test-pyjwt:latest
kind load docker-image hellokv:latest

##############################################
kubectl apply -f network-tester.yaml
kubectl apply -f 1-test-pyjwt.yaml

# in network-tester
curl -u test:test http://test-pyjwt/login
# {
#   "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3QiLCJleHAiOjE2OTE5ODM4MDB9._e6Nv2yRikSYrpeNg0i0BcNE0xkJAYBhkJe6hAnWoI4"
# }
kubectl delete -f 1-test-pyjwt.yaml

# follow this tutorial
# https://istio.io/latest/docs/tasks/security/authorization/authz-jwt/
# https://istio.io/latest/docs/tasks/security/authentication/authn-policy/#end-user-authentication

##############################################
# verify the raw service
kubectl apply -f 2-before-request-authorization.yaml
curl -X GET -i "hellokv/getkey" -H "Content-Type: application/json" -d '{ "key": "key1" }'
curl -X POST -i "hellokv/setkey" -H "Content-Type: application/json" -d '{ "key": "key1", "value": "value1" }'

# verify via ingress gateway
kubectl port-forward svc/istio-ingressgateway -n istio-system 8888:80
curl -X GET -i "localhost:8888/getkey" -H "Content-Type: application/json" -d '{ "key": "key1" }'
kubectl delete -f 2-before-request-authorization.yaml

##############################################
# add RequestAuthentication
kubectl apply -f 3-request-auth.yaml
kubectl port-forward svc/istio-ingressgateway -n istio-system 8888:80

# ACC - without token
curl -X GET -i "localhost:8888/getkey" -H "Content-Type: application/json" -d '{ "key": "key1" }'
# REJ - invalid token
curl --header "Authorization: Bearer deadbeef" -X GET -i "localhost:8888/getkey" -H "Content-Type: application/json" -d '{ "key": "key1" }'
# ACC - correct token
TOKEN=$(curl https://raw.githubusercontent.com/istio/istio/release-1.18/security/tools/jwt/samples/demo.jwt -s)
curl --header "Authorization: Bearer $TOKEN" -X GET -i "localhost:8888/getkey" -H "Content-Type: application/json" -d '{ "key": "key1" }'
kubectl delete -f 3-request-auth.yaml

##############################################
kubectl apply -f 4-request-auth-full-ingress.yaml
kubectl port-forward svc/istio-ingressgateway -n istio-system 8888:80

# same as step 3 should work.
# let's test other endpoints
# ACC - without token
curl localhost:8888/nginx
# REJ - invalid token
curl --header "Authorization: Bearer deadbeef" localhost:8888/nginx
# ACC - correct token
TOKEN=$(curl https://raw.githubusercontent.com/istio/istio/release-1.18/security/tools/jwt/samples/demo.jwt -s)
curl --header "Authorization: Bearer $TOKEN" localhost:8888/nginx

kubectl delete -f 4-request-auth-full-ingress.yaml

##############################################
kubectl apply -f 5-request-auth-partial.yaml

# ACC - invalid token
curl --header "Authorization: Bearer deadbeef" localhost:8888/nginx
# REJ - invalid token
curl --header "Authorization: Bearer deadbeef" -X GET -i "localhost:8888/getkey" -H "Content-Type: application/json" -d '{ "key": "key1" }'
TOKEN=$(curl https://raw.githubusercontent.com/istio/istio/release-1.18/security/tools/jwt/samples/demo.jwt -s)
curl --header "Authorization: Bearer $TOKEN" -X GET -i "localhost:8888/getkey" -H "Content-Type: application/json" -d '{ "key": "key1" }'

kubectl delete -f 5-request-auth-partial.yaml

##############################################
# Change the default behavoir: ACC without token
# https://istio.io/latest/docs/tasks/security/authentication/authn-policy/#require-a-valid-token
kubectl apply -f 6-rej-without-token.yaml

# REJ - without token
curl -X GET -i "localhost:8888/getkey" -H "Content-Type: application/json" -d '{ "key": "key1" }'
# REJ - invalid token
curl --header "Authorization: Bearer deadbeef" -X GET -i "localhost:8888/getkey" -H "Content-Type: application/json" -d '{ "key": "key1" }'
# ACC - correct token
TOKEN=$(curl https://raw.githubusercontent.com/istio/istio/release-1.18/security/tools/jwt/samples/demo.jwt -s)
curl --header "Authorization: Bearer $TOKEN" -X GET -i "localhost:8888/getkey" -H "Content-Type: application/json" -d '{ "key": "key1" }'

kubectl delete -f 6-rej-without-token.yaml

##############################################
# https://istio.io/latest/docs/tasks/security/authentication/claim-to-header/
kubectl apply -f 7-claim-to-header.yaml

# ACC - correct token
TOKEN=$(curl https://raw.githubusercontent.com/istio/istio/release-1.18/security/tools/jwt/samples/demo.jwt -s)
curl --header "Authorization: Bearer $TOKEN" -X GET -i "localhost:8888/getkey" -H "Content-Type: application/json" -d '{ "key": "key1" }'

# check the header
kubectl logs hellokv-v1-775d56c685-8bzgd
# X-Jwt-Claim-Foo: bar
