#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# Introduction: What is Kubeflow Pipelines?
# https://www.kubeflow.org/docs/components/pipelines/v2/introduction/

# we use a kind cluster as experiment environment
kind create cluster

export PIPELINE_VERSION=2.0.1

kubectl apply -k "github.com/kubeflow/pipelines/manifests/kustomize/cluster-scoped-resources?ref=$PIPELINE_VERSION"
kubectl wait --for condition=established --timeout=60s crd/applications.app.k8s.io
kubectl apply -k "github.com/kubeflow/pipelines/manifests/kustomize/env/dev?ref=$PIPELINE_VERSION"

# Access the UI
# looks good
kubectl -n kubeflow port-forward svc/ml-pipeline-ui 8080:80
