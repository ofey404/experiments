#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

npm start

# This toolchain is old and cumbersome, I can't make it work.
#
# https://www.chartjs.org/docs/latest/charts/radar.html

npm install chart.js react-chartjs-2
