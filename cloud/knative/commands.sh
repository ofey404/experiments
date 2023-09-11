#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# install kn CLI tool
wget https://github.com/knative/client/releases/download/knative-v1.11.0/kn-linux-amd64
chmod 774 kn-linux-amd64 
sudo mv kn-linux-amd64 /usr/local/bin/k

# create cluster
kind create cluster

# Installing Istio for Knative
#
# https://knative.dev/docs/install/installing-istio/#basic-installation-with-istioctl
wget https://github.com/istio/istio/releases/download/1.16.7/istio-1.16.7-linux-amd64.tar.gz
tar -xvzf istio-1.16.7-linux-amd64.tar.gz 
rm istio-1.16.7-linux-amd64.tar.gz 

./istio-1.16.7/bin/istioctl install -y

kubectl apply -f https://github.com/knative/operator/releases/download/knative-v1.11.0/operator.yaml
kubectl get deployment knative-operator
# NAME               READY   UP-TO-DATE   AVAILABLE   AGE
# knative-operator   1/1     1            1           20s

#####################################################################
# Knative serving
#####################################################################
kubectl apply -f manifests/serving.yaml

# configure DNS: no dns
kubectl get svc istio-ingressgateway -n istio-system
kubectl patch configmap/config-domain \
      --namespace knative-serving \
      --type merge \
      --patch '{"data":{"example.com":""}}'

# verify the serving endpoint
# TODO: make a PR to update this documentation.
#       It has a backward reference.
#       https://knative.dev/docs/install/operator/knative-with-operators/#configure-dns
#       > After starting your application, get the URL of your application:
#       But we don't know what's `your application`.
kn service create hello-example \
--image gcr.io/knative-samples/helloworld-go \
--env TARGET="First"
kubectl get ksvc
# NAME            URL                                        LATESTCREATED         LATESTREADY           READY   REASON
# hello-example   http://hello-example.default.example.com   hello-example-00001   hello-example-00001   True    

curl -H "Host: hello-example.default.example.com" http://localhost:8080
# Hello First!

#####################################################################
# Knative eventing
#####################################################################

kubectl apply -f manifests/eventing.yaml
