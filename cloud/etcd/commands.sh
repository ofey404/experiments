#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# From:
# https://etcd.io/docs/v3.4/dev-guide/interacting_v3/
export ETCDCTL_API=3

# get all keys
etcdctl get --prefix ""
etcdctl del key
