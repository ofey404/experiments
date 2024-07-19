#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

python ../python/1-getting-started.py

curl localhost:8000
# request_processing_seconds_count 4.0

go run .
# Metric: python_gc_objects_uncollectable_total
#   Value: {"label":[{"name":"generation","value":"0"}],"counter":{"value":0}}
#   Value: {"label":[{"name":"generation","value":"1"}],"counter":{"value":0}}
#   Value: {"label":[{"name":"generation","value":"2"}],"counter":{"value":0}}
# Metric: python_gc_collections_total
#   Value: {"label":[{"name":"generation","value":"0"}],"counter":{"value":40}}
#   Value: {"label":[{"name":"generation","value":"1"}],"counter":{"value":3}}
#   Value: {"label":[{"name":"generation","value":"2"}],"counter":{"value":0}}
# Metric: process_start_time_seconds
#   Value: {"gauge":{"value":1721290486.85}}
# Metric: request_processing_seconds
#   Value: {"summary":{"sample_count":111,"sample_sum":50.01380636503745}}
# Metric: process_open_fds
#   Value: {"gauge":{"value":11}}
# Metric: process_max_fds
#   Value: {"gauge":{"value":1048576}}
# Metric: request_processing_seconds_created
#   Value: {"gauge":{"value":1721290487.1421654}}
# Metric: python_gc_objects_collected_total
#   Value: {"label":[{"name":"generation","value":"0"}],"counter":{"value":365}}
#   Value: {"label":[{"name":"generation","value":"1"}],"counter":{"value":0}}
#   Value: {"label":[{"name":"generation","value":"2"}],"counter":{"value":0}}
# Metric: python_info
#   Value: {"label":[{"name":"implementation","value":"CPython"},{"name":"major","value":"3"},{"name":"minor","value":"10"},{"name":"patchlevel","value":"12"},{"name":"version","value":"3.10.12"}],"gauge":{"value":1}}
# Metric: process_virtual_memory_bytes
#   Value: {"gauge":{"value":178950144}}
# Metric: process_resident_memory_bytes
#   Value: {"gauge":{"value":21872640}}
# Metric: process_cpu_seconds_total
#   Value: {"counter":{"value":0.07}}o run .
# Metric: python_gc_objects_uncollectable_total
#   Value: {"label":[{"name":"generation","value":"0"}],"counter":{"value":0}}
#   Value: {"label":[{"name":"generation","value":"1"}],"counter":{"value":0}}
#   Value: {"label":[{"name":"generation","value":"2"}],"counter":{"value":0}}
# Metric: python_gc_collections_total
#   Value: {"label":[{"name":"generation","value":"0"}],"counter":{"value":40}}
#   Value: {"label":[{"name":"generation","value":"1"}],"counter":{"value":3}}
#   Value: {"label":[{"name":"generation","value":"2"}],"counter":{"value":0}}
# Metric: process_start_time_seconds
#   Value: {"gauge":{"value":1721290486.85}}
# Metric: request_processing_seconds
#   Value: {"summary":{"sample_count":111,"sample_sum":50.01380636503745}}
# Metric: request_processing_seconds_created
#   Value: {"gauge":{"value":1721290487.1421654}}
