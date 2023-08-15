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
./scripts/build.sh; ./scripts/load_to_kind.sh

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
# hellokv2.Hellokv2
grpcurl -plaintext hellokv-rpc:80 list hellokv2.Hellokv2
# hellokv2.Hellokv2.Get
# hellokv2.Hellokv2.Set
grpcurl -plaintext hellokv-rpc:80 describe hellokv2.Hellokv2.Get
# hellokv2.Hellokv2.Get is a method:
# rpc Get ( .hellokv.GetRequest ) returns ( .hellokv.GetResponse );
grpcurl -d '{"key": "hello"}' \
-plaintext hellokv-rpc:80 \
hellokv2.Hellokv2.Get
# ERROR:
#   Code: Unknown
#   Message: invalid objectId
grpcurl -d '{"key": "hello", "value": "world"}' \
-plaintext hellokv-rpc:80 \
hellokv2.Hellokv2.Set

# check HTTP service
curl -d '{"key": "hello"}' \
-H "Content-Type: application/json" \
-X POST hellokv-api/getkey

curl -d '{"key": "hello", "value": "world"}' \
-H "Content-Type: application/json" \
-X POST hellokv-api/setkey

# some visualization
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.18/samples/addons/prometheus.yaml
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.18/samples/addons/kiali.yaml
