#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

#operator-sdk init --domain example.com --repo github.com/example/memcached-operator
mkdir memcached-operator
cd memcached-operator
operator-sdk init --domain example.com --repo github.com/ofey404/experiments/cloud/k8s/operator_sdk/memcached-operator

operator-sdk create api --group cache --version v1alpha1 --kind Memcached --resource --controller
