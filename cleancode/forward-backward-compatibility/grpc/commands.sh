#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# This is a Forward/Backward compatible protobuf updating guide
#
# DDIA explains the pattern, there is a Chinese translation:
# https://github.com/Vonng/ddia/blob/master/ch4.md
# - It's view about changing type is a bit academic.
#
# Earthly has a detailed article about it:
# https://earthly.dev/blog/backward-and-forward-compatibility/
# - the safest method for modifying fields is to add a new one and deprecate the old field.
# - Sad to hear that they shut down the company.
#
# Protobuf has an official guide for updating:
# https://protobuf.dev/programming-guides/proto3/#updating
#
# Protocols are about consensus among people,
# which is harder to handle than code itself.
#
#
