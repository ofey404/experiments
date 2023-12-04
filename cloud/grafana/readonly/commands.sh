#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# Q: Can grafana be `readonly`? So that we can expose it to the public.
# 
#    https://grafana.com/docs/grafana/latest/administration/roles-and-permissions/
kind create cluster -n grafana-readonly
docker update --restart=no grafana-readonly-control-plane

# prometheus metrics
helm install prometheus prometheus-community/prometheus --version 25.8.0 --values prometheus.yaml

# loki + promtail log collection
helm install --values loki.yaml loki grafana/loki --version 5.39.0
kubectl apply -f promtail.yaml

# grafana dashboard
helm install grafana grafana/grafana --values grafana.yaml --version 7.0.11

# the workload
kubectl apply -f simple-log-generator.yaml

# check the dashboard
kubectl port-forward svc/grafana 80:80

# Then we create a user called readonly, give `Viewer` permission to it in the newly created grafana dashboard.

# delete the workload
kubectl delete -f simple-log-generator.yaml

#####################################################################
# Stage 2: Create dashboard through API
#####################################################################
