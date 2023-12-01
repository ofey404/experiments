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

# test environment
kind create cluster -n grafana-loki-multi-tanency
docker update --restart=no grafana-loki-multi-tanency-control-plane

# https://github.com/grafana/loki
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm install --values loki.yaml loki grafana/loki --version 5.39.0
