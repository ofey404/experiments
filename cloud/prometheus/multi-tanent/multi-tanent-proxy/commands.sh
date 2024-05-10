#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# Using a reverse proxy, to limit the query to a specific tenant.
#
# A nice guy implements similar logic in this repo:
# https://github.com/ikethecoder/prom-multi-tenant-proxy/tree/dev
#
# Diagram in this repo says we can use `relabel_configs:` to add 
# a label to any metrics, which would be easy to filter.
# https://github.com/ssbostan/prometheus-multi-tenant-proxy-server

# TODO: raw query to prometheus /query endpoint

# TODO: evaluate the performance of the proxy
