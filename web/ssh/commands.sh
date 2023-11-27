#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# For: Host key verification failed.
#
# The authenticity of host '[localhost]:80 ([127.0.0.1]:80)' can't be established.
# ED25519 key fingerprint is SHA256:jfbkxKir6N3qY2+Z+xi9BFoWfyiZb8UlG2/qMZyltM4.
# This key is not known by any other names
# Are you sure you want to continue connecting (yes/no/[fingerprint])? 
# Host key verification failed.
ssh-keygen -R hostname
