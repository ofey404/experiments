#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

minikube start --force --driver=docker
kubectl config use-context minikube

./deploy-kafka.sh 

# I fixed this script
# 
# Helm chart is here:
# 
# https://artifacthub.io/packages/helm/elastic/elasticsearch
# https://artifacthub.io/packages/helm/elastic/kibana
./deploy-es.sh 

# try kibana
kubectl port-forward svc/kibana-kibana 5601:5601
# username: elastic
# password:
kubectl get secrets --namespace=default elasticsearch-master-credentials -ojsonpath='{.data.password}' | base64 -d
# jHHLcWCjL1VmIZfC

./deploy-loki.sh
# To port forward Grafana to http://localhost:3000 'kubectl port-forward --namespace loki service/loki-grafana 3000:80'
# Credentials are 
# admin:SIyKd9gVsA52NJcQz0LW28wI6erIFRHIjtvFVOlH

./deploy-fluent-operator.sh

kubectl apply -f manifests/fluent-bit.yaml
kubectl apply -f manifests/outputs.yaml

# To double check the output:
# https://github.com/kubesphere-sigs/fluent-operator-walkthrough#how-to-check-the-configuration-and-data

# 1. fluent bit config
kubectl -n fluent get secrets fluent-bit-config -ojson | jq '.data."fluent-bit.conf"' | awk -F '"' '{printf $2}' | base64 --decode

# 2. check kafka message
# 
# NOTE: Don't install kcat locally, it can't find in-cluster kafka service from broker.
kubectl apply -f manifests/kafka-tester.yaml

# In kafka-tester container
kcat -C -b my-cluster-kafka-brokers.kafka.svc:9092 -t fluent-log

# get log from kafka-tester container
kubectl exec -it kafka-tester -- \
kcat -C -b my-cluster-kafka-brokers.kafka.svc:9092 -t fluent-log

minikube stop
