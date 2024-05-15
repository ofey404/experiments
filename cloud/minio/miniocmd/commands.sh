#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# https://github.com/minio/mc

wget https://dl.min.io/client/mc/release/linux-amd64/mc
chmod +x mc
./mc --help
sudo mv mc -t /usr/local/bin

ALIAS=myminio

# create an alias for the server
mc alias set $ALIAS HOSTNAME ACCESS_KEY SECRET_KEY

# test connection
mc admin info $ALIAS
mc ls $ALIAS

# "interactive mode"
# while true
# do
#   echo -n "mc> "
#   read cmd
#   mc $cmd
# done


# alicloud css
mc config host add s3 https://oss-cn-beijing.aliyuncs.com $AK $SK --api s3v4
