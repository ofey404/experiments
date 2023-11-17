#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

#####################################################################
# 1. test ssh server in docker
#####################################################################

# https://hub.docker.com/r/linuxserver/openssh-server
docker run -d \
  --name=openssh-server \
  --hostname=openssh-server `#optional` \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Etc/UTC \
  -e SUDO_ACCESS=false `#optional` \
  -e PASSWORD_ACCESS=true `#optional` \
  -e USER_PASSWORD=password `#optional` \
  -e USER_NAME=linuxserver.io `#optional` \
  -p 2222:2222 \
  --restart unless-stopped \
  lscr.io/linuxserver/openssh-server:9.3_p2-r0-ls136

# password: password
ssh linuxserver.io@localhost -p 2222
# Welcome to OpenSSH Server
# openssh-server:~$ 

#####################################################################
# 2. ssh multiplex in kubernetes
#####################################################################

kubectl apply -f single-port-multiplex.yaml

ssh linuxserver.io@ssh-multiplex-0.ssh-multiplex.default.svc.cluster.local -p 2222

ssh linuxserver.io@localhost -p 31400