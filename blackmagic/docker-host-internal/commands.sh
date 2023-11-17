#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# host.docker.internal is a special docker DNS name,
# which points to the host machine.

python -m http.server
# Serving HTTP on 0.0.0.0 port 8000 (http://0.0.0.0:8000/) ...

docker run --rm nicolaka/netshoot:v0.9 curl http://host.docker.internal:8000
# ...
# </ul>
# <hr>
# </body>
# </html>
# 100  1360  100  1360    0     0  38908      0 --:--:-- --:--:-- --:--:-- 40000

# output of http.server:
# 127.0.0.1 - - [17/Nov/2023 15:18:06] "GET / HTTP/1.1" 200 -
