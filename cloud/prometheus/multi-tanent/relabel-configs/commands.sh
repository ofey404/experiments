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
# set relabel_configs
#####################################################################

kind create cluster -n prometheus-relabel-configs
docker update --restart=no prometheus-relabel-configs-control-plane

# Installation
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

# check the values
helm pull prometheus-community/prometheus --version 25.8.0 --untar
rm -rf prometheus/

helm install prometheus prometheus-community/prometheus --version 25.8.0 --values prometheus.yaml
kubectl port-forward svc/prometheus-server 80:80

kubectl apply -f pod-with-user1-label.yaml 

#####################################################################
# Conclusion:
#  - relabel_configs is not for adding a label to any metrics.
#  - it's not quite compatible with existing components like kube-state-metrics and node-exporter.
# So, it's not quite useful for our purpose.
#####################################################################

