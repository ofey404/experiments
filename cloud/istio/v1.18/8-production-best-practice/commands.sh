#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# Q: Which profile should I use?
#
# Tutorial:
# https://istio.io/latest/docs/setup/additional-setup/config-profiles/
istioctl profile list
# Istio configuration profiles:
#     ambient
#     default
#     demo
#     empty
#     external
#     minimal
#     openshift
#     preview
#     remote

mkdir -p profiles
pushd profiles
    ALL_PROFILES="ambient \
                default \
                demo \
                empty \
                external \
                minimal \
                openshift \
                preview \
                remote"
    for p in $ALL_PROFILES; do
        istioctl profile dump $p > $p.yaml
    done
popd

# do some diff
diff -y profiles/demo.yaml profiles/default.yaml
# default profile has
# 1. no egress gateway
# 2. more resource for components
# 3. autoscale enabled
