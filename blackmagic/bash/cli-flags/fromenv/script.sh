#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

if [[ -z "${FLAG_1:-}" || -z "${FLAG_2:-}" ]]; then
  echo "Usage: FLAG_1={val1} FLAG_2={val2} $0"
  exit 1
fi

FLAG_1=${FLAG_1}
FLAG_2=${FLAG_2}

# NOTICE(ofey404): This idea doesn't work!
# help on any error
# trap 'print_help' ERR
# print_help() {
#   echo "Usage: FLAG_1={val1} FLAG_2={val2} $0"
# }

echo "FLAG_1 = $FLAG_1"
echo "FLAG_2 = $FLAG_2"
