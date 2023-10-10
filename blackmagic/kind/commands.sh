#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# How to configure kind cluster to not start automatically after reboots? #2631
# https://github.com/kubernetes-sigs/kind/issues/2631
docker update --restart=no container-id


# after image is loaded, we should set:
# imagePullPolicy: IfNotPresent
# 
# KiND - How I Wasted a Day Loading Local Docker Images
# https://iximiuz.com/en/posts/kubernetes-kind-load-docker-image/
kind load docker-image myimage:latest -n clustername