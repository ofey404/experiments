#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

helm repo add harbor https://helm.goharbor.io

# check the chart
helm pull harbor/harbor --version 1.13.0 --untar
rm -rf harbor

helm upgrade --install harbor harbor/harbor \
--version 1.13.0 \
--set logLevel=debug

# Add this to /etc/hosts
# https://core.harbor.domain

# Harbor Invalid user name or password in port forward
# 
# It requires a https external URL to login correctly.
# https://stackoverflow.com/questions/76037183/harbor-invalid-user-name-or-password-in-port-forward
kubectl port-forward svc/harbor-portal 80:80

# default password
# admin
# Harbor12345
#
# Add this to docker config:
# "insecure-registries" : ["core.harbor.domain"]
# then restart daemon
