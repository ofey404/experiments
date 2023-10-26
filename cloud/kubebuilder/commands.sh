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
