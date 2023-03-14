#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

# ###################################################################
# Kafka cheatsheet
# See https://kafka.apache.org/quickstart
# ###################################################################

# create topic
kafka-topics.sh --create --topic quickstart-events --bootstrap-server localhost:9092

# write events
kafka-console-producer.sh --topic quickstart-events --bootstrap-server localhost:9092

# read events
kafka-console-consumer.sh --topic quickstart-events --from-beginning --bootstrap-server localhost:9092
