#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

torchrun \
    --standalone \
    --nnodes=1 \
    --nproc-per-node=2 \
    local_rank.py
# master_addr is only used for static rdzv_backend and when rdzv_endpoint is not specified.
# WARNING:torch.distributed.run:
# *****************************************
# Setting OMP_NUM_THREADS environment variable for each process to be 1 in default, to avoid your system being overloaded, please further tune the variable for optimal performance in your application as needed. 
# *****************************************
# local_rank: 0
# local_rank: 1