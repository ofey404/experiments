#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# https://volcano.sh/zh/docs/installation/

kind create cluster -n volcano
docker update --restart=no volcano-control-plane

helm repo add volcano-sh https://volcano-sh.github.io/helm-charts

helm repo update

helm install volcano volcano-sh/volcano -n volcano-system --create-namespace

# check the volcano components' status
kubectl get all -n volcano-system

# Quickstart:
#
# https://volcano.sh/zh/docs/tutorials/

kubectl apply -f queue.yaml
kubectl apply -f job.yaml 
kubectl apply -f job-2.yaml 
