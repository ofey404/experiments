#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

python -m pip install -r requirements.txt 

python download_dataset.py lhoestq/demo1 data/demo1
python download_model.py facebook/detr-resnet-50 model/detr-resnet-50

# transfer this to a k8s cluster
kubectl apply -f downloader.yaml

FILES="download_dataset.py requirements.txt"
for f in $FILES; do
    kubectl cp $f huggingface-downloader:/root/$f -c app
done

# in pod huggingface-downloader:
cd /root
pip install -r requirements.txt -i https://mirrors.ivolces.com/pypi/simple/
python download_dataset.py lhoestq/demo1 data/demo1
