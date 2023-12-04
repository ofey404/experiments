#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

helm install grafana grafana/grafana --version 7.0.11

# check the values
helm pull grafana/grafana --version 7.0.11 --untar
rm -rf grafana/

# grafana.yaml sets the admin password as `admin`
helm install grafana grafana/grafana --values grafana.yaml --version 7.0.11

kubectl port-forward svc/grafana 80:80
