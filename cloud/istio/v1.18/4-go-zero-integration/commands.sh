#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

PATH=$PATH:$(pwd)/../istio-1.18.2/bin

./scripts/generate.sh

# build docker file
./scripts/build.sh
kind load docker-image hellokv2-api:latest
kind load docker-image hellokv2-rpc:latest

# run a local test
docker run -it --rm \
-v $(pwd)/cmd/api/etc:/config \
-p 8888:8888 \
hellokv2-api:latest \
-f /config/hellokv2.yaml
# Starting server at 0.0.0.0:8888...

docker start kind-control-plane

# set up mongodb
helm install mongodb oci://registry-1.docker.io/bitnamicharts/mongodb \
--set auth.rootPassword=RootPassword
# check mongodb credential in its pod
mongosh --host 127.0.0.1 --authenticationDatabase admin -u root -p RootPassword
# mongodb cheatsheet
# show dbs
# use hellokv
# db.kv.find()
# db.kv.deleteMany({})

# set up service

kubectl apply -f deploy/all.yaml
kubectl apply -f deploy/network-tester.yaml

# check RPC service
# in network-tester
grpcurl -plaintext hellokv-rpc:80 list
# grpc.health.v1.Health
# grpc.reflection.v1alpha.ServerReflection
# hellokv.Hellokv
grpcurl -plaintext hellokv-rpc:80 list hellokv.Hellokv
# hellokv.Hellokv.Get
# hellokv.Hellokv.Set
grpcurl -plaintext hellokv-rpc:80 describe hellokv.Hellokv.Get
# hellokv.Hellokv.Get is a method:
# rpc Get ( .hellokv.GetRequest ) returns ( .hellokv.GetResponse );
grpcurl -d '{"key": "hello"}' \
-plaintext hellokv-rpc:80 \
hellokv.Hellokv.Get
# ERROR:
#   Code: Unknown
#   Message: invalid objectId
grpcurl -d '{"key": "hello", "value": "world"}' \
-plaintext hellokv-rpc:80 \
hellokv.Hellokv.Set
