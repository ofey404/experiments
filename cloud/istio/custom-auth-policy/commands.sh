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
# There is an example: Envoy External Authorization server (envoy.ext_authz) with OPA HelloWorld
# https://github.com/salrashid123/envoy_external_authz

go run .
# Starting rpc server at 0.0.0.0:8000, mode dev...

grpcurl -plaintext localhost:8000 list
# envoy.service.auth.v3.Authorization
# grpc.health.v1.Health
# grpc.reflection.v1.ServerReflection
# grpc.reflection.v1alpha.ServerReflection
