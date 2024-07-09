#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# List service & method, describe elements
#
# Take cloud/istio/custom-auth-policy/ext_authz.go as an example

grpcurl -plaintext localhost:8000 list
# envoy.service.auth.v3.Authorization
# grpc.health.v1.Health
# grpc.reflection.v1.ServerReflection
# grpc.reflection.v1alpha.ServerReflection

grpcurl -plaintext localhost:8000 list envoy.service.auth.v3.Authorization
# envoy.service.auth.v3.Authorization.Check

grpcurl -plaintext localhost:8000 describe envoy.service.auth.v3.Authorization.Check
# envoy.service.auth.v3.Authorization.Check is a method:
# rpc Check ( .envoy.service.auth.v3.CheckRequest ) returns ( .envoy.service.auth.v3.CheckResponse );

grpcurl -plaintext localhost:8000 describe .envoy.service.auth.v3.CheckRequest
# envoy.service.auth.v3.CheckRequest is a message:
# message CheckRequest {
#   option (.udpa.annotations.versioning) = { previous_message_type:"envoy.service.auth.v2.CheckRequest" };
#   .envoy.service.auth.v3.AttributeContext attributes = 1;
# }


# How to enable reflection on server side:
#
# ```go
# import "google.golang.org/grpc/reflection"
# ...
#     reflection.Register(s)
# ```

# calling example
grpcurl -d '{"key": "hello"}' \
-plaintext localhost:8080 \
hellokv2.Hellokv2.Get
# {
#   "value": "world2"
# }
