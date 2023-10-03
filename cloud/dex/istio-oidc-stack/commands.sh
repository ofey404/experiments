#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# THIS SCRIPT IS BROKEN

# This scrip follows the steps of this awesome article
# https://datastrophic.io/secure-kubeflow-ingress-and-authentication/

# istio 1.12.1 supports 1.19, 1.20, 1.21, 1.22

# We use rancher, cause kind doesn't have a public IP
sudo rm -rf /etc/kubernetes/* /var/lib/etcd/*
docker run -d --restart=unless-stopped --name rancher -p 8080:80 -p 8443:443 --privileged rancher/rancher:v2.6.10
docker logs rancher  2>&1 | grep "Bootstrap Password:"

# Randomly generated password
# Mo0fmASUGPWiv38a

#####################################################################
# Install cert-manager, istio
#####################################################################

# cert-manager
helm repo add jetstack https://charts.jetstack.io
helm repo update  
helm install cert-manager jetstack/cert-manager \
  --version v1.6.1 \
  --set installCRDs=true \
  --namespace cert-manager \
  --create-namespace

# istio
helm repo add istio https://istio-release.storage.googleapis.com/charts
helm repo update  
helm install istio-base istio/base \
  --version 1.12.1 \
  --namespace istio-system \
  --create-namespace  
helm install istiod istio/istiod \
  --version 1.12.1 \
  --namespace istio-system \
  --wait

# create gateway
helm install istio-ingressgateway istio/gateway \
  --version 1.12.1 \
  --namespace ingress \
  --create-namespace
  --wait

# port forward
kubectl port-forward svc/istio-ingressgateway -n ingress 8080:80
kubectl port-forward svc/istio-ingressgateway -n ingress 8443:443

#####################################################################
# Creating CA ClusterIssuer for signing certificates
#####################################################################

# install CFSSL: Cloudflare's PKI and TLS toolkit
go install github.com/cloudflare/cfssl/cmd/...@latest

cfssl gencert -initca csr.json | cfssljson -bare ca
# 2023/10/02 17:18:26 [INFO] generating a new CA key and certificate from CSR
# 2023/10/02 17:18:26 [INFO] generate received request
# 2023/10/02 17:18:26 [INFO] received CSR
# 2023/10/02 17:18:26 [INFO] generating key: rsa-2048
# 2023/10/02 17:18:27 [INFO] encoded CSR
# 2023/10/02 17:18:27 [INFO] signed certificate with serial number 557186031755043389515824923068919452064465878613

kubectl create secret tls ca-secret \
  --namespace cert-manager \
  --cert=ca.pem \
  --key=ca-key.pem

kubectl apply -f cluster-issuer.yaml
kubectl get clusterissuer -o wide
# NAME        READY   STATUS                AGE
# ca-issuer   True    Signing CA verified   17s

kubectl apply -f certificate.yaml
kubectl apply -f gateway.yaml

# Connection with CA would be accepted.
curl --cacert ca.pem -v https://127.0.0.1:8443
# < HTTP/2 404 
# < date: Mon, 02 Oct 2023 09:29:44 GMT
# < server: istio-envoy
# < 
# * Connection #0 to host 127.0.0.1 left intact

#####################################################################
# Authorizing user requests
#####################################################################

# this namespace has sidecar injection
kubectl apply -f namespace-auth.yaml

sudo apt install apache2-utils -y
# hash for `password`
htpasswd -bnBC 10 "" password | tr -d ':\n'
# $2y$10$/7EdQXN7bSo4OZH0pS8X.u90ZaSRoY.RLwShWj3Pi0LGYFTQoGKlq

helm repo add dex https://charts.dexidp.io
helm repo update

helm install dex dex/dex \
  --version 0.6.3 \
  --values dex-values.yaml \
  --namespace auth \
  --wait

kubectl apply -f virtualservice-dex.yaml

# install oauth2 proxy
helm repo add oauth2-proxy https://oauth2-proxy.github.io/manifests
helm repo update

helm install oauth2-proxy oauth2-proxy/oauth2-proxy \
  --version 5.0.6 \
  --namespace auth \
  --values oauth2-proxy-values.yaml \
  --wait
