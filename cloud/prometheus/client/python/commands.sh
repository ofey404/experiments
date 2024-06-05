#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# Github: https://github.com/prometheus/client_python
# Doc:
# https://prometheus.github.io/client_python/getting-started/three-step-demo/

pip install prometheus-client

python 1-getting-started.py

curl localhost:8000
# # HELP request_processing_seconds Time spent processing request
# # TYPE request_processing_seconds summary
# request_processing_seconds_count 32.0
# request_processing_seconds_sum 15.854171441969811
# # HELP request_processing_seconds_created Time spent processing request
# # TYPE request_processing_seconds_created gauge
# request_processing_seconds_created 1.717558857653486e+09

#####################################################################
# 2. labels
#####################################################################

python 2-label.py 

curl localhost:8000
# # HELP request_processing_seconds Time spent processing request
# # TYPE request_processing_seconds summary
# request_processing_seconds_count{my_label_key="my_label_value"} 7.0
# request_processing_seconds_sum{my_label_key="my_label_value"} 4.344608151998727
# # HELP request_processing_seconds_created Time spent processing request
# # TYPE request_processing_seconds_created gauge
# request_processing_seconds_created{my_label_key="my_label_value"} 1.7175745435510569e+09


#####################################################################
# 3. on the fly
#####################################################################

python 3-create-onthefly.py

curl localhost:8000
# static 0.1

ps aux | grep 3-create-onthefly.py
kill -SIGUSR1 $PID
# add metrics on the fly

curl localhost:8000
# static 1.0
# dynamic 1.0