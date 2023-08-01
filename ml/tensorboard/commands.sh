#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

pip install tensorboard
python train.py

docker run -it --rm -p 0.0.0.0:6006:6006 -v $(pwd)/runs/:/tensorboard_logs/ tensorflow/tensorflow:2.5.1 /usr/local/bin/tensorboard --logdir=/tensorboard_logs/ --host 0.0.0.0
docker run -it --rm -p 0.0.0.0:6006:6006 -v $(pwd)/output/:/tensorboard_logs/ tensorflow/tensorflow:2.5.1 /usr/local/bin/tensorboard --logdir=/tensorboard_logs/ --host 0.0.0.0

# logdir/  <- --logdir
#     volumeMount1/
#     volumeMount2/
