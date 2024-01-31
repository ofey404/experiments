#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# scan all ports on a host
sudo nmap -n -PN -sT -sU -p- --min-rate 5000 '{ip}'
# Starting Nmap 7.80 ( https://nmap.org ) at 2024-01-31 14:41 CST
# PORT     STATE SERVICE
# 22/tcp   open  ssh
# 80/tcp   open  http
# ...

# rescan on the machine
netstat -plunt | grep -v "127.0.0.1"
# Active Internet connections (only servers)
# Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
# tcp        0      0 0.0.0.0:55113           0.0.0.0:*               LISTEN      897/rpc.mountd
# tcp        0      0 0.0.0.0:111             0.0.0.0:*               LISTEN      1/systemd
# tcp        0      0 0.0.0.0:179             0.0.0.0:*               LISTEN      2528011/bird
# ...
