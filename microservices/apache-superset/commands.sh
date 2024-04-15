#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# https://superset.apache.org/docs/quickstart/
#
# docker-compose-image-tag.yml and docker/
# are from: https://github.com/apache/superset/blob/master/

docker compose up
# http://localhost:8088
# username: admin
# password: admin

# Visit host.docker.internal to access local/port-forward databases

#####################################################################
# 2. Installing on Kubernetes
# https://superset.apache.org/docs/installation/running-on-kubernetes
#####################################################################

kind create cluster -n superset
docker update --restart=no superset-control-plane

helm repo add superset https://apache.github.io/superset
helm search repo superset
# NAME                    CHART VERSION   APP VERSION     DESCRIPTION                                       
# superset/superset       0.12.9          4.0.0           Apache Superset is a modern, enterprise-ready b...

# If you want to see the default values
helm show values superset/superset > superset-default-values.yaml

# Create a SECRET_KEY with `openssl rand -base64 42` or you'll get:
# > Refusing to start due to insecure SECRET_KEY
helm install superset superset/superset --values values/1-standalone.yaml
# NAME: superset
# LAST DEPLOYED: Mon Apr 15 15:45:03 2024
# NAMESPACE: default
# STATUS: deployed
# REVISION: 1
# TEST SUITE: None
# NOTES:
# 1. Get the application URL by running these commands:
#   echo "Visit http://127.0.0.1:8088 to use your application"
#   kubectl port-forward service/superset 8088:8088 --namespace default

#####################################################################
# 3. Bring our own database
#####################################################################

helm uninstall superset # clean the previous installation

helm install postgresql bitnami/postgresql \
     --version 15.2.5 \
     --set auth.postgresPassword=mysecretpassword

CREATE DATABASE superset;

helm install superset superset/superset --values values/2-use-standalone-postgres.yaml 
# NAME: superset
# LAST DEPLOYED: Mon Apr 15 16:23:42 2024
# NAMESPACE: default
# STATUS: deployed
# REVISION: 1
# TEST SUITE: None
# NOTES:
# 1. Get the application URL by running these commands:
#   echo "Visit http://127.0.0.1:8088 to use your application"
#   kubectl port-forward service/superset 8088:8088 --namespace default
