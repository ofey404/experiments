#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# download kubebuilder and install locally.
curl -L -o kubebuilder "https://go.kubebuilder.io/dl/latest/$(go env GOOS)/$(go env GOARCH)"
chmod +x kubebuilder && sudo mv kubebuilder /usr/local/bin/

kubebuilder version
# Version: main.version{KubeBuilderVersion:"3.12.0", KubernetesVendor:"1.27.1", GitCommit:"b48f95cd5384eadcdfd02a47a02910f72ddc7ea8", BuildDate:"2023-09-06T06:04:11Z", GoOs:"linux", GoArch:"amd64"}

kubebuilder completion bash

# Add this to bashrc
# kubebuilder autocompletion
. <(kubebuilder completion bash)

# 1. init project as a standalone go module
mkdir -p ~/projects/guestbook
cd ~/projects/guestbook
kubebuilder init --domain my.domain --repo my.domain/guestbook

# 2. init project as a subpackage of an existing module
mkdir -p projects/guestbook
cd projects/guestbook
kubebuilder init --domain my.domain
rm go.mod go.sum
# Then modify the Dockerfile, point the root path to the existing go.mod
