#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

kind create cluster -n pvc-storage-monitor
docker update --restart=no pvc-storage-monitor-control-plane

kubectl apply -f all.yaml

# in cluster
apt update
apt install -y vim

# In cluster:

cd /data/
du -sh .
# 4.0K    .


pip install psutil

# execute those
python print_storage.py 
# Total disk space in /data: 1006.85 GiB
# Used disk space in /data: 122.51 GiB
# Free disk space in /data: 833.13 GiB
# Percentage of disk used in /data: 12.8%

# Q1. psutil doesn't shows `requests` correctly.