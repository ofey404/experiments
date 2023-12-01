#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# Cortex: A horizontally scalable, highly available, multi-tenant, long term Prometheus.
# https://github.com/cortexproject/cortex

# https://cortexmetrics.io/docs/getting-started/

# Not a wise choice to use it in production, since it's not widely adopted.
# Using a non-standard component would cause maintenance burden.
