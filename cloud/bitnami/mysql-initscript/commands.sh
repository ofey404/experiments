#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

kind create cluster -n mysql-bitnami
docker update --restart=no mysql-bitnami-control-plane

helm install mysql bitnami/mysql --version 9.12.3 --values ./values.yaml 
