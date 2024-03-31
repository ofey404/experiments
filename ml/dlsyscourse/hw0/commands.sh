#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

python -m pytest -k "add"

python -m pytest -k "test_parse_mnist"

python -m pytest -k "test_softmax_loss"

python -m pytest -k "test_softmax_regression_epoch"
python -m pytest -k "test_softmax_regression_epoch_cpp" # cpp


python -m pytest -k "test_nn_single_layer_epoch"  # my helper
python -m pytest -k "test_nn_epoch"
