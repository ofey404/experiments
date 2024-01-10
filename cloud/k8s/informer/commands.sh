#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

go run .
# Starting the watcher
# kubeconfig Host: https://127.0.0.1:39231
# Job image-builder created
# Job image-builder updated,
# ## From
# {}
# ## To
# {
#     "startTime": "2024-01-10T07:14:50Z",
#     "active": 1,
#     "uncountedTerminatedPods": {},
#     "ready": 0
# }
# Job image-builder updated,
# ## From
# {
#     "startTime": "2024-01-10T07:14:50Z",
#     "active": 1,
#     "uncountedTerminatedPods": {},
#     "ready": 0
# }
# ## To
# {
#     "startTime": "2024-01-10T07:14:50Z",
#     "active": 1,
#     "uncountedTerminatedPods": {},
#     "ready": 1
# }
# Job image-builder updated,
# ## From
# {
#     "startTime": "2024-01-10T07:14:50Z",
#     "active": 1,
#     "uncountedTerminatedPods": {},
#     "ready": 1
# }
# ## To
# {
#     "startTime": "2024-01-10T07:14:50Z",
#     "active": 1,
#     "uncountedTerminatedPods": {},
#     "ready": 0
# }
# Job image-builder updated,
# ## From
# {
#     "startTime": "2024-01-10T07:14:50Z",
#     "active": 1,
#     "uncountedTerminatedPods": {},
#     "ready": 0
# }
# ## To
# {
#     "startTime": "2024-01-10T07:14:50Z",
#     "uncountedTerminatedPods": {
#         "succeeded": [
#             "848a1a1e-db28-4f74-84dd-26da7e6a506f"
#         ]
#     },
#     "ready": 0
# }
# Job image-builder updated,
# ## From
# {
#     "startTime": "2024-01-10T07:14:50Z",
#     "uncountedTerminatedPods": {
#         "succeeded": [
#             "848a1a1e-db28-4f74-84dd-26da7e6a506f"
#         ]
#     },
#     "ready": 0
# }
# ## To
# {
#     "conditions": [
#         {
#             "type": "Complete",
#             "status": "True",
#             "lastProbeTime": "2024-01-10T07:15:04Z",
#             "lastTransitionTime": "2024-01-10T07:15:04Z"
#        }
#      ],
#     "startTime": "2024-01-10T07:14:50Z",
#     "completionTime": "2024-01-10T07:15:04Z",
#     "succeeded": 1,
#     "uncountedTerminatedPods": {},
#     "ready": 0
# }
