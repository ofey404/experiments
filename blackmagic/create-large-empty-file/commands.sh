#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# create a 5G file
#
# It's very fast because it's one system call which
# does block preallocation (e.g. it reserves the space
# but does minimal I/O), where as dd'ing from /dev/zero
# to a file involves a load of read/writes.
# 
# The blocks are marked as uninitialized at the filesystem
# level, but when you read them the blocks returned to
# userspace will be zero filled.
fallocate -l 5G fallocate.largefile

# benchmark
dd if=/dev/zero of=dd.largefile bs=1M count=5120
# 5368709120 bytes (5.4 GB, 5.0 GiB) copied, 4.55314 s, 1.2 GB/s

# In this dd command,
# only one byte is really written
dd if=/dev/zero of=dd-seek.largefile count=1 bs=1 seek=$((10 * 1024 * 1024 * 1024 - 1))
# 1 byte copied, 6.86e-05 s, 14.6 kB/s

ls -la --block-size=M
# -rw-r--r-- 1 ofey ofey 10240M Aug 23 11:09 dd-seek.largefile
# -rw-r--r-- 1 ofey ofey  5120M Aug 23 11:09 dd.largefile
# -rw-r--r-- 1 ofey ofey  5120M Aug 23 11:08 fallocate.largefile

rm *.largefile
