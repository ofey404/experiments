#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

while getopts "f:n:" opt; do
  case $opt in
    f)
      echo "Flag -f is set with value: $OPTARG"
      OPT_F=$OPTARG
      ;;
    n)
      echo "Flag -n is set with value: $OPTARG"
      OPT_N=$OPTARG
      ;;
    \?)
      # Exit if an invalid option is provided
      exit 1
      ;;
  esac
done

# Check if no flags were processed
if [ $OPTIND -eq 1 ]; then
  echo "Usage: $0 -f file -n name"
  exit 1
fi

echo "-f = $OPT_F"
echo "-n = $OPT_N"
