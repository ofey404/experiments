#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################


# on x86_64
docker build -t hello-world:build-on-x86 .
docker run -it --rm hello-world:build-on-x86
# Hello, world.

# on mac (ARM)
docker buildx build --platform linux/amd64 -t hello-world:build-on-arm .
docker save hello-world:build-on-arm -o hello-world.tar

# copy hello-world.tar back to a x86_64 machine
# to cross validate it.
docker load -i hello-world.tar
