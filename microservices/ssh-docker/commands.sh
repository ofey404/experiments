#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

PUBLIC_KEY=$(cat ~/.ssh/id_rsa.pub)
echo $PUBLIC_KEY

docker run -it --rm -e PUBLIC_KEY="$PUBLIC_KEY" -p 2222:2222 linuxserver/openssh-server:version-9.6_p1-r0

# or
docker run -it --rm -e PASSWORD_ACCESS="true" -e USER_PASSWORD=password -p 2222:2222 linuxserver/openssh-server:version-9.6_p1-r0

ssh -p 2222 linuxserver.io@localhost
# Welcome to OpenSSH Server
