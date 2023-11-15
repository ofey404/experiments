#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# set up an experiment environment
kind create cluster -n mongo
docker update --restart=no mongo-control-plane

helm repo add bitnami https://charts.bitnami.com/bitnami

######################################################################
# Use helm
######################################################################
# root:password
helm install mongodb bitnami/mongodb --version 13.9.4 --values values.yaml

# use 27027 to avoid conflict with local mongodb
while true; do kubectl port-forward svc/mongodb 27027:27017; done

######################################################################
# a persistent test environment
######################################################################
docker run -it --rm --name mastering-mongo \
           -p 27017:27017 \
           -e MONGO_INITDB_ROOT_USERNAME=root \
           -e MONGO_INITDB_ROOT_PASSWORD=password \
           -v /tmp/mastering-mongo/data/db:/data/db \
           mongo:7.0.2

# The connection string
mongosh mongodb://root:password@localhost:27017
