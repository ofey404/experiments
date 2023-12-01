#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

#  User could modify things ┌────────────────────┐ ┌────────────────────────┐
#  above this line          │ Workload of user1  │ │ Grafana of user1       │
# ──────────────────────────┼────────────────────┼─┼────────────────────────┼─
#  User cannot modify, only │ Promtail:          │ │ Istio Sidecar:         │
#  admin could configure    │   tenant_id: user1 │ │   X-Scope-OrgID: user1 │
#                           └┬───────────────────┘ └┬──────────────────────▲┘
#                            │                      │                      │
#                            │                      │                      │
#                            │              Force the req to have    Only return user1's
#                    tenant_id = user1      X-Scope-OrgID = user1    log entries
#                            │                      │                      │
#                            │                      │                      │
#                           ┌▼──────────────────────▼──────────────────────┴┐
#                           │       Loki: auth_enabled = true               │
#                           └───────────────────────────────────────────────┘
# Refs:
# https://grafana.com/docs/loki/latest/operations/multi-tenancy/
# https://medium.com/otomi-platform/multi-tenancy-with-loki-promtail-and-grafana-demystified-e93a2a314473
#
# Envoy filter refs:
# https://istio.io/latest/docs/reference/config/networking/envoy-filter/

# test environment
kind create cluster -n grafana-loki-multi-tanency
docker update --restart=no grafana-loki-multi-tanency-control-plane

# install istio
istioctl install --set profile=demo -y
kubectl label namespace default istio-injection=enabled

# https://github.com/grafana/loki
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm install --values loki.yaml loki grafana/loki --version 5.39.0

# First, we create a grafana that could access loki with X-Scope-OrgID=user1
kubectl apply -f grafana/configmap.yaml
kubectl apply -f grafana/user1.yaml
kubectl port-forward svc/grafana-user1 3000:3000

# check the http header is appended
kubectl apply -f request-visualizer.yaml
# ssh into grafana pod
curl request-visualizer
# GET request,
# Path: /
# Headers:
#     x-scope-orgid: user1
#     ...

kubectl apply -f workload/user1.yaml

# set up another user
kubectl apply -f grafana/user2.yaml
kubectl apply -f workload/user2.yaml

# launch grafana at 3000, 3001
kubectl port-forward svc/grafana-user1 3000:3000
kubectl port-forward svc/grafana-user2 3001:3000

# each user's grafana could only see its own log entries
# it's enforced by `X-Scope-OrgID = user1` in all outbound requests
