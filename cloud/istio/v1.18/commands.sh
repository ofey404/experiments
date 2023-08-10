#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# set up cluster with
kind create cluster --image kindest/node:v1.27.3
docker stop kind-control-plane
docker start kind-control-plane

curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.18.2 TARGET_ARCH=x86_64 sh -
PATH=$PATH:$(pwd)/istio-1.18.2/bin

istioctl install --set profile=demo -y
# check the profile
istioctl profile dump demo

# For the workload, we use hellokv:latest
# The service code is in: microservices/go-zero/hellokv/commands.sh
# 
# Weird behaviors here!!!
# KiND - How I Wasted a Day Loading Local Docker Images
# https://iximiuz.com/en/posts/kubernetes-kind-load-docker-image/
kind load docker-image hellokv:latest

kubectl apply -f manifest/hellokv.yaml
kubectl apply -f manifest/network-tester.yaml

# in network-tester pod
# verify the service is running
IP=10.244.0.9

curl -X GET -i "$IP:8888/getkey" \
-H "Content-Type: application/json" \
-d '{ "key": "key1" }'
# key not found

curl -X POST -i "$IP:8888/setkey" \
-H "Content-Type: application/json" \
-d '{ "key": "key1", "value": "value1" }'
# 200 OK

# enable injection
kubectl label namespace default istio-injection=enabled

kubectl apply -f manifest/hellokv.yaml
kubectl apply -f manifest/network-tester.yaml

# go in network-tester pod again
IP=10.244.0.11

# we can still access the service
curl -X GET -i "$IP:8888/getkey" \
-H "Content-Type: application/json" \
-d '{ "key": "key1" }'
# key not found

kubectl delete -f manifest/hellokv.yaml
kubectl delete -f manifest/network-tester.yaml

#####################################################################
# Istio feature test
#####################################################################

# all with istio
kubectl apply -f manifest/all-with-istio.yaml

INGRESS_SERVICE=
# Now we have Gateway, visit it
kubectl port-forward svc/istio-ingressgateway -n istio-system 8888:80

curl -X GET -i "localhost:8888/getkey" \
-H "Content-Type: application/json" \
-d '{ "key": "key1" }'
