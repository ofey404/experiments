#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# Installation
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

# check the values
helm pull prometheus-community/prometheus --version 25.8.0 --untar
rm -rf prometheus/

helm install prometheus prometheus-community/prometheus --version 25.8.0



