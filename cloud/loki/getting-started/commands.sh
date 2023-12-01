#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# test environment
kind create cluster -n sidecar-playground
docker update --restart=no sidecar-playground-control-plane

# https://github.com/grafana/loki
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update
helm install --values loki.yaml loki grafana/loki --version 5.39.0

# if you want to check the content
helm pull grafana/loki --version 5.39.0 --untar

# visualize with grafana
kubectl apply -f grafana.yaml
kubectl port-forward svc/grafana 3000:3000
# check the datasource configuration

# install promtail
kubectl apply -f promtail.yaml
# loki URL: http://loki:3100

kubectl apply -f simple-log-generator.yaml
# In `Explore` dashboard, use the following query:
#   {pod="simple-log-generator"}

# API access
kubectl port-forward svc/loki 3100:3100
python pull-log.py
# Sleep to wait for logs to be generated
# {
#   "status": "success",
#   "data": {
#     "resultType": "streams",
#     "result": [
#       {
#         "stream": {
#           "container": "myapp-container",
#           "filename": "/var/log/pods/default_simple-log-generator_813289c1-0bd7-4449-b7ae-a4d236b3d8b7/myapp-container/0.log",
#           "job": "default/simple-log-generator",
#           "namespace": "default",
#           "pod": "simple-log-generator"
#         },
#         "values": [
#           [
#             "1701335999191774634",
#             "2023-11-30T09:19:59.161441499Z stdout F Thu Nov 30 09:19:59 UTC 2023"
#           ],
#           [
#             "1701335998189390261",
#             "2023-11-30T09:19:58.160529948Z stdout F Thu Nov 30 09:19:58 UTC 2023"
#           ],
#           [
#             "1701335997185632134",
#             "2023-11-30T09:19:57.158740694Z stdout F Thu Nov 30 09:19:57 UTC 2023"
#           ]
#         ]
#       }
#     ],
#     "stats": {
#       "summary": {
#         "bytesProcessedPerSecond": 76352,
#         "linesProcessedPerSecond": 1122,
#         "totalBytesProcessed": 204,
#         "totalLinesProcessed": 3,
#         "execTime": 0.002672,
#         "queueTime": 4.4e-05,
#         "subqueries": 0,
#         "totalEntriesReturned": 3,
#         "splits": 0,
#         "shards": 0,
#         "totalPostFilterLines": 3,
#         "totalStructuredMetadataBytesProcessed": 0
#       },
#       "querier": {
#         "store": {
#           "totalChunksRef": 0,
#           "totalChunksDownloaded": 0,
#           "chunksDownloadTime": 0,
#           "chunk": {
#             "headChunkBytes": 0,
#             "headChunkLines": 0,
#             "decompressedBytes": 0,
#             "decompressedLines": 0,
#             "compressedBytes": 0,
#             "totalDuplicates": 0,
#             "postFilterLines": 0,
#             "headChunkStructuredMetadataBytes": 0,
#             "decompressedStructuredMetadataBytes": 0
#           }
#         }
#       },
#       "ingester": {
#         "totalReached": 1,
#         "totalChunksMatched": 1,
#         "totalBatches": 2,
#         "totalLinesSent": 3,
#         "store": {
#           "totalChunksRef": 0,
#           "totalChunksDownloaded": 0,
#           "chunksDownloadTime": 0,
#           "chunk": {
#             "headChunkBytes": 204,
#             "headChunkLines": 3,
#             "decompressedBytes": 0,
#             "decompressedLines": 0,
#             "compressedBytes": 0,
#             "totalDuplicates": 0,
#             "postFilterLines": 3,
#             "headChunkStructuredMetadataBytes": 0,
#             "decompressedStructuredMetadataBytes": 0
#           }
#         }
#       },
#       "cache": {
#         "chunk": {
#           "entriesFound": 0,
#           "entriesRequested": 0,
#           "entriesStored": 0,
#           "bytesReceived": 0,
#           "bytesSent": 0,
#           "requests": 0,
#           "downloadTime": 0
#         },
#         "index": {
#           "entriesFound": 0,
#           "entriesRequested": 0,
#           "entriesStored": 0,
#           "bytesReceived": 0,
#           "bytesSent": 0,
#           "requests": 0,
#           "downloadTime": 0
#         },
#         "result": {
#           "entriesFound": 0,
#           "entriesRequested": 0,
#           "entriesStored": 0,
#           "bytesReceived": 0,
#           "bytesSent": 0,
#           "requests": 0,
#           "downloadTime": 0
#         },
#         "statsResult": {
#           "entriesFound": 0,
#           "entriesRequested": 0,
#           "entriesStored": 0,
#           "bytesReceived": 0,
#           "bytesSent": 0,
#           "requests": 0,
#           "downloadTime": 0
#         }
#       }
#     }
#   }
# }