#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# Share code between API & RPC Services

# Serve HTTP
go run . -f etc/hellokv-api.yaml
# Starting HTTP server at 0.0.0.0:8888...

# HTTP test
curl -v localhost:8888/setkey -H "Content-Type: application/json" \
-d '{ "key": "myKey", "value": "myValue" }'
curl -v localhost:8888/getkey -H "Content-Type: application/json" \
-d '{ "key": "myKey" }'
# {"value":"myValue"}

# Serve gRPC
go run . -f etc/hellokv.yaml
# Starting rpc server at 0.0.0.0:8080...

# gRPC test
grpcurl -d '{"key": "hello", "value":"world"}' \
-plaintext localhost:8080 \
hellokv.Hellokv.Set
grpcurl -d '{"key": "hello"}' \
-plaintext localhost:8080 \
hellokv.Hellokv.Get
# {
#   "value": "world"
# }

grpcurl -plaintext localhost:8080 list

