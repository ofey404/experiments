#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# This directory creates a service with custom metrics,
# make the prometheus to scrape it.

kind create cluster -n prometheus-custom-metrics
docker update --restart=no prometheus-custom-metrics-control-plane

helm install prometheus prometheus-community/prometheus --version 25.8.0
kubectl port-forward svc/prometheus-server 8080:80
