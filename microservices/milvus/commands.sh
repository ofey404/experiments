#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# start
#
# CAUTION: we use milvusdb/milvus:2.3-20240328-4021f447
#          since the tutorial version is not compatible with the hello_milvus.ipynb
docker-compose up -d
# [+] Running 4/4
#  ✔ Network milvus               Created                                                                                               0.1s 
#  ✔ Container milvus-etcd        Started                                                                                               0.6s 
#  ✔ Container milvus-minio       Started                                                                                               0.6s 
#  ✔ Container milvus-standalone  Started                                                                                               0.2s 

pip install pymilvus==2.3.7

# check hello_milvus.ipynb

docker-compose down
