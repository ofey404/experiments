#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# Full process description,
# See: https://www.volcengine.com/docs/6349/871351

yum install epel-release
sudo apt install s3fs

echo $VOLCENGINE_ACCESS_KEY:$VOLCENGINE_SECRET_KEY > .passwd-s3fs

scp .passwd-s3fs MACHINE:/root/.passwd-s3fs
# OR
nano /root/.passwd-s3fs

chmod 600 /root/.passwd-s3fs

mkdir /mnt/tos
s3fs {bucket-name} /mnt/tos -o passwd_file=${HOME}/.passwd-s3fs -o url=http://{S3 Endpoint} -d -o f2

# verify
df -hT
# s3fs           fuse.s3fs  256T     0  256T   0% /mnt/tos
