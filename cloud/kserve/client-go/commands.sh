#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

go run .
# 2023/09/13 18:09:33 Index: 0 VirtualService Hosts: [sklearn-iris.default.svc.cluster.local sklearn-iris.default.example.com]
# 2023/09/13 18:09:33 Index: 1 VirtualService Hosts: [sklearn-iris-predictor.default sklearn-iris-predictor.default.example.com sklearn-iris-predictor.default.svc sklearn-iris-predictor.default.svc.cluster.local]
# 2023/09/13 18:09:33 Index: 2 VirtualService Hosts: [sklearn-iris-predictor.default sklearn-iris-predictor.default.svc sklearn-iris-predictor.default.svc.cluster.local]

go build -o ./istio-crd-checker .
kubectl apply -f rbac.yaml
kubectl apply -f istio-crd-checker.yaml

kubectl cp ./istio-crd-checker istio-crd-checker:/istio-crd-checker -c myapp-container
