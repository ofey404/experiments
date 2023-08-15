#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# prepare test env: hellokv2
kubectl apply -f all-with-tele-patch.yaml

#####################################################################
# Installation Telepresence
#
# 1. Download the latest binary (~50 MB):
sudo curl -fL https://app.getambassador.io/download/tel2/linux/amd64/latest/telepresence -o /usr/local/bin/telepresence
# 2. Make the binary executable:
sudo chmod a+x /usr/local/bin/telepresence

telepresence version
# Client     : v2.14.2
# Root Daemon: not running
# User Daemon: not running

telepresence helm install
telepresence connect

telepresence list
# hellokv-api: ready to intercept (traffic-agent not yet installed)
# hellokv-rpc: ready to intercept (traffic-agent not yet installed)
# mongodb    : ready to intercept (traffic-agent not yet installed)

#####################################################################
# 1. Local DNS resolution
# local request -> [local service] -> cluster services

# check the DNS
# CAUTION: The `.default` namespace suffix is required.
grpcurl -plaintext hellokv-rpc.default:80 list
# grpc.health.v1.Health
# grpc.reflection.v1alpha.ServerReflection
# hellokv2.Hellokv2

# start a local service with custom config
pushd ../../4-go-zero-integration
    go run cmd/api/hellokv2.go \
    -f ../5-local-development/1-telepresence/hellokv-api-local.yaml
    # Starting server at 0.0.0.0:8888...
popd

# verify that the local service can access the cluster resource
curl -d '{"key": "hello"}' \
-H "Content-Type: application/json" \
-X POST localhost:8888/getkey
# {"value":"world2"}

#####################################################################
# 2. Service Interception
# cluster request -> cluster services -> [local service] -> in-cluster db

# CAUTION: the DNS of mongodb -> mongodb.default
pushd ../../4-go-zero-integration
    go run cmd/rpc/hellokv2.go \
    -f ../5-local-development/1-telepresence/hellokv-rpc-local.yaml
    # Starting rpc server at 0.0.0.0:8080...
popd

# 1. check the [local service] -> in-cluster db
grpcurl -plaintext localhost:8080 list
grpcurl -d '{"key": "hello"}' \
-plaintext localhost:8080 \
hellokv2.Hellokv2.Get
# {
#   "value": "world2"
# }

# 2. inject this local service into the cluster
# NOTE:
# https://github.com/telepresenceio/telepresence/issues/2623
telepresence list
telepresence intercept hellokv-rpc --port 8080

# visit the API service,
# which is mapped into local DNS hellokv-api.default
curl -d '{"key": "hello"}' \
-H "Content-Type: application/json" \
-X POST hellokv-api.default/getkey
# {"value":"world2"}

# stop interception
telepresence leave hellokv-rpc

#####################################################################
telepresence helm uninstall
