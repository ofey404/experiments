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


#####################################################################
# goofys sometimes fails.
# tos_mount_fix.sh allows an ordinary user to mount it again.
cat <<EOF > tos_mount_fix.sh
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
\$BUCKET /mnt/tos
EOF
chmod 774 tos_mount_fix.sh
mv tos_mount_fix.sh -t /usr/local/bin/

visudo
# Add this line:
# 
# ALL ALL=NOPASSWD: /usr/local/bin/tos_mount_fix.sh
sudo tos_mount_fix.sh
