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

helm show values prometheus-community/prometheus --version 25.8.0 > values.yaml

kubectl apply -f example-service.yaml

helm upgrade prometheus prometheus-community/prometheus --version 25.8.0 --values values.yaml

kubectl port-forward svc/prometheus-server 8080:80
# Now in prometheus console we could find `requests_total` metrics
# It should be 0

# check the metrics with my eyes
kubectl port-forward svc/example-service 8888:80
# visit http://localhost:8888/metrics

curl localhost:8888/
# Hello, world!
#
# Pod log:
# Starting server at :8080                                                                                                              │
# Request received, /   
#
# In prometheus
# requests_total{instance="example-service:80", job="example-service"} 8
