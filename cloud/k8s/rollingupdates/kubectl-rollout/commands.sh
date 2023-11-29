#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# test the service code

PORT=8888 VERSION=1.0 python service.py
curl localhost:8888
# GET request for /, VERSION=1.0

PORT=8888 VERSION=2.0 python service.py
curl localhost:8888
# GET request for /, VERSION=2.0

kubectl apply -f python-deployment.yaml

kubectl port-forward svc/python-deployment 80:80
curl localhost:80
# GET request for /, VERSION=1.1

kubectl get deploy
# NAME                READY   UP-TO-DATE   AVAILABLE   AGE
# python-deployment   1/1     1            1           115s

kubectl scale deploy python-deployment --replicas 3
# NAME                READY   UP-TO-DATE   AVAILABLE   AGE
# python-deployment   1/3     3            1           2m36s

# query to visualize the rolling update
rm python-deployment.log
while true; do curl localhost:80 >> python-deployment.log ; done

kubectl set env deployment/python-deployment VERSION=2.0
# or
kubectl edit deployment python-deployment

# In log:
# GET request for /, VERSION=1.1
# GET request for /, VERSION=1.1
# GET request for /, VERSION=2.0
# GET request for /, VERSION=2.0

# pause and resume deployment
kubectl rollout status deployment python-deployment
# deployment "python-deployment" successfully rolled out

kubectl set env deployment/python-deployment VERSION=3.0

# pause and resume
kubectl rollout pause deployment/python-deployment
kubectl rollout resume deployment/python-deployment

# force trigger a new rollout
kubectl rollout restart deployment/python-deployment