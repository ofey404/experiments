#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

kubectl create ns fluid-system

helm repo add fluid https://fluid-cloudnative.github.io/charts
helm repo update

helm install fluid fluid/fluid

kubectl get po -n fluid-system

kubectl create -f dataset.yaml -f runtime.yaml -f app.yaml

##############################################
# Inside the container
##############################################

kubectl exec -it demo-app -- bash

du -sh /data/spark/spark-3.4.0/spark-3.4.0-bin-without-hadoop.tgz
# 287M    /data/spark/spark-3.4.0/spark-3.4.0-bin-without-hadoop.tgz
time cp /data/spark/spark-3.4.0/spark-3.4.0-bin-without-hadoop.tgz /dev/null
# real    0m46.987s
# user    0m0.003s
# sys     0m0.948s

##############################################
# Demonstrate the effect of cache
##############################################

# Recreate the application
kubectl delete -f app.yaml && kubectl create -f app.yaml

kubectl exec -it demo-app -- bash
time cp /data/spark/spark-3.4.0/spark-3.4.0-bin-without-hadoop.tgz /dev/null
# real    0m0.543s
# user    0m0.000s
# sys     0m0.094s
