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
# c61c72211e21: Loading layer [==================================================>]  1.782MB/1.782MB
# Loaded image: hello-world:build-on-arm

# on x86_64 again
docker run -it --rm hello-world:build-on-arm
# Hello, world.

# NOTE: buildx works on all machines,
#       we can use the same set of commands across platforms.
docker buildx build --platform linux/amd64 -t hello-world:build-on-x86-use-buildx .

# run x86 machine on arm
docker save hello-world:build-on-x86 -o hello-world-x86.tar
# then on arm
docker run --platform linux/amd64 -t hello-world:build-on-x86
# Hello, world.
