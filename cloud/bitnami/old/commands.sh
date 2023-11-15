#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

minikube start

helm install mysql --values mysql.yaml bitnami/mysql

helm install etcd --values etcd.yaml bitnami/etcd

helm install redis --values redis.yaml bitnami/redis