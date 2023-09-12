#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

kind create cluster -n kserve

# I use the `quickstart` configuration
# https://kserve.github.io/website/0.11/get_started/#install-the-kserve-quickstart-environment
curl -s "https://raw.githubusercontent.com/kserve/kserve/release-0.11/hack/quick_install.sh" | bash

# First inference service
# https://kserve.github.io/website/master/get_started/first_isvc/#run-your-first-inferenceservice
kubectl create namespace kserve-test
kubectl apply -f manifests/first-inference-service.yaml

kubectl -n istio-system port-forward svc/istio-ingressgateway 8080:80
curl -v -H "Host: sklearn-iris.default.example.com" -H "Content-Type: application/json" "http://localhost:8080/v1/models/sklearn-iris:predict" -d @./iris-input.json
# {"predictions":[1,1]}
