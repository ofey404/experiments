#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# We follow this guide:
# https://github.com/NVIDIA/gpu-feature-discovery

# Firstly, we should get a cluster with NVIDIA GPU.

#####################################################################
# 1. the minimum demonstration setup.
#####################################################################

# Install NFD
kubectl apply -f https://raw.githubusercontent.com/NVIDIA/gpu-feature-discovery/v0.8.1/deployments/static/nfd.yaml

# Install GFD.
kubectl apply -f https://raw.githubusercontent.com/NVIDIA/gpu-feature-discovery/v0.8.1/deployments/static/gpu-feature-discovery-daemonset.yaml

# apiVersion: v1
# kind: Node
# metadata:
#   ...
#   labels:
#     nvidia.com/cuda.driver.major: "470"
#     nvidia.com/cuda.driver.minor: "129"
#     nvidia.com/cuda.driver.rev: "06"
#     nvidia.com/cuda.runtime.major: "11"
#     nvidia.com/cuda.runtime.minor: "4"
#     nvidia.com/gfd.timestamp: "1697523911"
#     nvidia.com/gpu.compute.major: "7"
#     nvidia.com/gpu.compute.minor: "5"
#     nvidia.com/gpu.count: "1"
#     nvidia.com/gpu.family: turing
#     nvidia.com/gpu.machine: OpenStack-Nova
#     nvidia.com/gpu.memory: "15109"
#     nvidia.com/gpu.product: Tesla-T4
#     nvidia.com/gpu.replicas: "1"
#     nvidia.com/mig.capable: "false"
#   ...

kubectl delete -f https://raw.githubusercontent.com/NVIDIA/gpu-feature-discovery/v0.8.1/deployments/static/gpu-feature-discovery-daemonset.yaml
kubectl delete -f https://raw.githubusercontent.com/NVIDIA/gpu-feature-discovery/v0.8.1/deployments/static/nfd.yaml

#####################################################################
# 2. the production deployment with `helm`
#####################################################################

helm repo add nvgfd https://nvidia.github.io/gpu-feature-discovery

helm search repo nvgfd --devel
# NAME                            CHART VERSION   APP VERSION     DESCRIPTION                                       
# nvgfd/gpu-feature-discovery     0.8.1           0.8.1           A Helm chart for gpu-feature-discovery on Kuber...

helm pull nvgfd/gpu-feature-discovery --untar --version 0.8.1

helm upgrade -i nvgfd nvgfd/gpu-feature-discovery \
  --version 0.8.1 \
  --namespace gpu-feature-discovery \
  --create-namespace
