#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

kubectl apply -f ssh-withpassword.yaml 

kubectl port-forward svc/ssh 2222:2222

ssh -p 2222 linuxserver.io@localhost
# using password
# Welcome to OpenSSH Server
