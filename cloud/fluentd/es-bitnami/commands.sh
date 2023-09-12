#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

kind create cluster -n es-bitnami

# install the es stack
# Helm chart: https://artifacthub.io/packages/helm/bitnami/elasticsearch
helm repo add bitnami https://charts.bitnami.com/bitnami
helm upgrade --install elasticsearch bitnami/elasticsearch --version 19.11.1 --values values/es.yaml
helm upgrade --install kibana bitnami/kibana --version 10.5.2 --values values/kibana.yaml

helm repo add fluent https://fluent.github.io/helm-charts
helm upgrade --install fluent-operator fluent/fluent-operator --version 2.4.0 --values values/fluent-operator.yaml

kubectl apply -f manifests/spinner.yaml

kubectl port-forward svc/kibana 5601:5601

#####################################################################
# Using helm chart
#####################################################################

kind create cluster -n es-helm-chart
kubectl config use-context kind-es-helm-chart

cd logging-chart/
    helm dependency build
cd -
helm upgrade --install logging-chart logging-chart/