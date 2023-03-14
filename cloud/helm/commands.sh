#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

minikube start

# Install helm
wget https://get.helm.sh/helm-v3.11.1-linux-amd64.tar.gz
tar -zxvf helm-v3.11.1-linux-amd64.tar.gz 
sudo mv linux-amd64/helm /usr/local/bin/helm
rm -rf helm-v3.11.1-linux-amd64.tar.gz linux-amd64/

# Basic usage
helm repo add bitnami https://charts.bitnami.com/bitnami
helm search repo bitnami

helm repo update  
helm install bitnami/mysql --generate-name

helm search hub wordpress

# Create a chart
helm create my-first-chart
helm install my-first-chart ./my-first-chart/
helm uninstall my-first-chart

# push image to AWS
./push_to_aws.sh

helm get manifest my-first-chart 

helm install --debug --dry-run my-first-chart ./my-first-chart/
helm upgrade my-first-chart ./my-first-chart/
