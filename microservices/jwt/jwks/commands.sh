#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

go run .
# {
#   "aud": [
#     "Golang Users"
#   ],
#   "iat": 500,
#   "iss": "ofey404@test.com",
#   "sub": "https://github.com/lestrrat-go/jwx/v2/jwt"
# }
# eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOlsiR29sYW5nIFVzZXJzIl0sImlhdCI6NTAwLCJpc3MiOiJvZmV5NDA0QHRlc3QuY29tIiwic3ViIjoiaHR0cHM6Ly9naXRodWIuY29tL2xlc3RycmF0LWdvL2p3eC92Mi9qd3QifQ.gq0Ixv8mO8Y1lqDXbCOIuP1AMAxOMLosRdnv1ELZmblOwgfXNpHq1tvGez3jezwxF9x4fnLad8X9D5CT4yDzqHT4OIkoApEeN2BFBvP5i2zRPI9jqsjtzk0q_QWzw3EIhQk4htMd-E9YYGzNctDU4UDjRrL_6r971qYb1Y3ntKs

docker start kind-control-plane
kubectl config use-context kind-kind

kubectl apply -f ../../../snippets/request-visualzier.yaml

kubectl port-forward svc/request-visualizer 8080:80

curl localhost:8080

# check the pod log:
# app INFO:root:Starting httpd...
# app
# app INFO:root:GET request,
# app Path: /
# app Headers:
# app Host: localhost:8080
# app User-Agent: curl/7.81.0
# app Accept: */*
# app
# app
# app
# app 127.0.0.1 - - [25/Aug/2023 07:40:01] "GET / HTTP/1.1" 200 -

kubectl apply -f virtual-service.yaml

kubectl port-forward svc/istio-ingressgateway -n istio-system 8080:80

curl localhost:8080/request-visualizer
# ok

#####################################################################
# 1. basic case

kubectl apply -f rules/1-request-authentication.yaml

curl -v localhost:8080/request-visualizer
# not ok
curl -v --header "Authorization: Bearer deadbeef" localhost:8080/request-visualizer
# not ok
curl -v --header "Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOlsiR29sYW5nIFVzZXJzIl0sImlhdCI6NTAwLCJpc3MiOiJvZmV5NDA0QHRlc3QuY29tIiwic3ViIjoiaHR0cHM6Ly9naXRodWIuY29tL2xlc3RycmF0LWdvL2p3eC92Mi9qd3QifQ.gq0Ixv8mO8Y1lqDXbCOIuP1AMAxOMLosRdnv1ELZmblOwgfXNpHq1tvGez3jezwxF9x4fnLad8X9D5CT4yDzqHT4OIkoApEeN2BFBvP5i2zRPI9jqsjtzk0q_QWzw3EIhQk4htMd-E9YYGzNctDU4UDjRrL_6r971qYb1Y3ntKs" localhost:8080/request-visualizer
# ok

kubectl delete -f rules/1-request-authentication.yaml

#####################################################################
# 2. certain user only

kubectl apply -f rules/2-certain-user.yaml

curl -v localhost:8080/request-visualizer
# not ok
curl -v --header "Authorization: Bearer deadbeef" localhost:8080/request-visualizer
# not ok
curl -v --header "Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOlsiR29sYW5nIFVzZXJzIl0sImlhdCI6NTAwLCJpc3MiOiJvZmV5NDA0QHRlc3QuY29tIiwic3ViIjoiaHR0cHM6Ly9naXRodWIuY29tL2xlc3RycmF0LWdvL2p3eC92Mi9qd3QifQ.gq0Ixv8mO8Y1lqDXbCOIuP1AMAxOMLosRdnv1ELZmblOwgfXNpHq1tvGez3jezwxF9x4fnLad8X9D5CT4yDzqHT4OIkoApEeN2BFBvP5i2zRPI9jqsjtzk0q_QWzw3EIhQk4htMd-E9YYGzNctDU4UDjRrL_6r971qYb1Y3ntKs" localhost:8080/request-visualizer
# ok

kubectl apply -f rules/2.5-certain-user-not-the-one.yaml

curl -v --header "Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOlsiR29sYW5nIFVzZXJzIl0sImlhdCI6NTAwLCJpc3MiOiJvZmV5NDA0QHRlc3QuY29tIiwic3ViIjoiaHR0cHM6Ly9naXRodWIuY29tL2xlc3RycmF0LWdvL2p3eC92Mi9qd3QifQ.gq0Ixv8mO8Y1lqDXbCOIuP1AMAxOMLosRdnv1ELZmblOwgfXNpHq1tvGez3jezwxF9x4fnLad8X9D5CT4yDzqHT4OIkoApEeN2BFBvP5i2zRPI9jqsjtzk0q_QWzw3EIhQk4htMd-E9YYGzNctDU4UDjRrL_6r971qYb1Y3ntKs" localhost:8080/request-visualizer
# not ok

kubectl delete -f rules/2.5-certain-user-not-the-one.yaml

#####################################################################
# 3. claim to header

kubectl apply -f rules/

kubectl apply -f rules/3-claim-to-header.yaml
curl -v --header "Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJhdWQiOlsiR29sYW5nIFVzZXJzIl0sImlhdCI6NTAwLCJpc3MiOiJvZmV5NDA0QHRlc3QuY29tIiwic3ViIjoiaHR0cHM6Ly9naXRodWIuY29tL2xlc3RycmF0LWdvL2p3eC92Mi9qd3QifQ.gq0Ixv8mO8Y1lqDXbCOIuP1AMAxOMLosRdnv1ELZmblOwgfXNpHq1tvGez3jezwxF9x4fnLad8X9D5CT4yDzqHT4OIkoApEeN2BFBvP5i2zRPI9jqsjtzk0q_QWzw3EIhQk4htMd-E9YYGzNctDU4UDjRrL_6r971qYb1Y3ntKs" localhost:8080/request-visualizer
# x-jwt-claim-sub: https://github.com/lestrrat-go/jwx/v2/jwt
