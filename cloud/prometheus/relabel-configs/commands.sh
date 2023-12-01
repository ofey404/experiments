#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# This experiment is a predecessor of ../multi-tenant-proxy/
#
# Diagram in this repo says we can use `relabel_configs:` to add 
# a label to any metrics, which would be easy to filter.
# https://github.com/ssbostan/prometheus-multi-tenant-proxy-server

#####################################################################
# 1. follow ../commands.sh
#####################################################################

# Installation
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

# check the values
helm pull prometheus-community/prometheus --version 25.8.0 --untar
rm -rf prometheus/

helm install prometheus prometheus-community/prometheus --version 25.8.0
kubectl port-forward svc/prometheus-server 80:80

helm install grafana grafana/grafana --values grafana.yaml --version 7.0.11
kubectl port-forward svc/grafana 80:80
# password is generated
kubectl get secret --namespace default grafana -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

# we could add the following panels:
#
# https://grafana.com/grafana/dashboards/1860-node-exporter-full/
# https://grafana.com/grafana/dashboards/15760-kubernetes-views-pods/

#####################################################################
# 2. set relabel_configs
#####################################################################





