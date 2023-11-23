#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

go run .
# func 2 intend to run forever
# func 2 intend to run forever
# ...
# func 2 intend to run forever
# func 1
# panic: func 1 panic
#
# goroutine 6 [running]:
# main.main.func1()
#         /home/ofey/cloud-workspace/experiments/language/go/endmainprocess/onpanic/main.go:12 +0x65
# created by main.main
#         /home/ofey/cloud-workspace/experiments/language/go/endmainprocess/onpanic/main.go:10 +0x6a
# exit status 2
