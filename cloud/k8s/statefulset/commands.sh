#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# Like a Deployment, a StatefulSet manages Pods that are based on an identical
# container spec. Unlike a Deployment, a StatefulSet maintains a sticky identity
# for each of its Pods.
#
# https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/#stable-network-id

kubectl apply -f ../../../snippets/network-tester.yaml
kubectl apply -f statefulset.yaml

# enter network-tester
curl web-0.nginx.default.svc.cluster.local	
curl web-1.nginx.default.svc.cluster.local	
curl web-2.nginx.default.svc.cluster.local	

# only 3 replicas, we won't find the 4th one
curl web-3.nginx.default.svc.cluster.local	
# curl: (6) Could not resolve host: web-3.nginx.default.svc.cluster.local
