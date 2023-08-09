#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

wget https://github.com/kahing/goofys/releases/download/v0.24.0/goofys
mv goofys /usr/local/bin/
chmod +x /usr/local/bin/goofys
goofys -version

cat <<EOF > credentials
[default]
aws_access_key_id = $VOLCENGINE_ACCESS_KEY
aws_secret_access_key = $VOLCENGINE_SECRET_KEY
s3 = 
   addressing_style = virtual:
EOF

mkdir /root/.aws
scp credentials MACHINE:/root/.aws/credentials
# OR
nano /root/.aws/credentials

goofys --subdomain --dir-mode=0777 --file-mode=0666 --profile default --endpoint=https://{S3 Endpoint} -o allow_other {bucket-name} /mnt/tos

# verify
df -hT

# check the permission
ls -la /mnt/
