#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# Allow invalid certificates for resources loaded from localhost.
# As of v119 and later, the flag you want is WebTransport Developer Mode.
#
# https://stackoverflow.com/questions/62699391/how-to-bypass-certificate-errors-using-microsoft-edge
#
# OR: type thisisunsafe
