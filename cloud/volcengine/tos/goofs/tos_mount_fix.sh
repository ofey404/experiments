#!/usr/bin/env bash
set -x             # for debug
set -euo pipefail  # fail early

# clear the ground
umount /mnt/tos || true

BUCKET="<bucket_name>"

echo mount tos to /mnt/tos

/usr/local/bin/goofys \
--subdomain \
--dir-mode=0777 \
--file-mode=0666 \
--profile default \
--endpoint=https://tos-s3-cn-beijing.ivolces.com \
-o allow_other \
$BUCKET /mnt/tos