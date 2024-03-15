#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

apt-get update
apt-get -y install nfs-kernel-server rpcbind
service rpcbind start
service nfs-common start

mount -t nfs 10.20.xx.xx:/home /home
