#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# Install helm
wget https://get.helm.sh/helm-v3.11.1-linux-amd64.tar.gz
tar -zxvf helm-v3.11.1-linux-amd64.tar.gz 
sudo mv linux-amd64/helm /usr/local/bin/helm
rm -rf helm-v3.11.1-linux-amd64.tar.gz linux-amd64/

# add repo
helm repo add bitnami https://charts.bitnami.com/bitnami
# search things in the repo
helm search repo bitnami

helm repo update  
helm install bitnami/mysql --generate-name

helm search hub wordpress

# download chart from hub
helm pull kubeflow/kubeflow --version 1.5.1 --untar

# install helm diff plugin
helm plugin install https://github.com/databus23/helm-diff

# print out the yaml
helm template --debug {args}
