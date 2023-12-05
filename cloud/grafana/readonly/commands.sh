#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

# Q: Can grafana be `readonly`? So that we can expose it to the public.
# 
#    https://grafana.com/docs/grafana/latest/administration/roles-and-permissions/
kind create cluster -n grafana-readonly
docker update --restart=no grafana-readonly-control-plane

# prometheus metrics
helm install prometheus prometheus-community/prometheus --version 25.8.0 --values prometheus.yaml

# loki + promtail log collection
helm install --values loki.yaml loki grafana/loki --version 5.39.0
kubectl apply -f promtail.yaml

# grafana dashboard
helm install grafana grafana/grafana --values grafana.yaml --version 7.0.11

# the workload
kubectl apply -f simple-log-generator.yaml

# check the dashboard
kubectl port-forward svc/grafana 80:80

# Then we create a user called readonly, give `Viewer` permission to it in the newly created grafana dashboard.

# delete the workload
kubectl delete -f simple-log-generator.yaml

#####################################################################
# Stage 2: Create dashboard through API
#####################################################################

# Check API access
kubectl apply -f network-tester.yaml

# in pod
curl http://admin:admin@grafana/api/org
# {"id":1,"name":"Main Org.","address":{"address1":"","address2":"","city":"","zipCode":"","state":"","country":""}}

# get api token
curl -X POST -H "Content-Type: application/json" \
     -H "Authorization: Basic $(echo -n 'admin:admin' | base64)" \
     -d '{"name":"api_token", "role":"Admin", "secondsToLive":0}' \
     http://grafana/api/auth/keys
# {"id":1,"name":"api_token","key":"eyJrIjoiVDFqaUpvd0FuZm82dHBYRmZmTzlsbDJGTlF3d0JGVkUiLCJuIjoiYXBpX3Rva2VuIiwiaWQiOjF9"}

curl -H "Authorization: Bearer eyJrIjoiVDFqaUpvd0FuZm82dHBYRmZmTzlsbDJGTlF3d0JGVkUiLCJuIjoiYXBpX3Rva2VuIiwiaWQiOjF9" \
     -H "Content-Type: application/json" \
     http://grafana/api/search
# [
#   {
#     "id": 1,
#     "uid": "a8f8605c-19a6-449f-bec1-6dde5248d889",
#     "title": "New dashboard",
#     "uri": "db/new-dashboard",
#     "url": "/d/a8f8605c-19a6-449f-bec1-6dde5248d889/new-dashboard",
#     "slug": "",
#     "type": "dash-db",
#     "tags": [],
#     "isStarred": false,
#     "sortMeta": 0
#   }
# ]

# set id uid to null
curl -H "Authorization: Bearer eyJrIjoiVDFqaUpvd0FuZm82dHBYRmZmTzlsbDJGTlF3d0JGVkUiLCJuIjoiYXBpX3Rva2VuIiwiaWQiOjF9" \
     -H "Content-Type: application/json" \
     http://grafana/api/dashboards/db -d '{
  "dashboard": {
    "annotations": {
        "list": [
        {
            "builtIn": 1,
            "datasource": {
            "type": "grafana",
            "uid": "-- Grafana --"
            },
            "enable": true,
            "hide": true,
            "iconColor": "rgba(0, 211, 255, 1)",
            "name": "Annotations & Alerts",
            "type": "dashboard"
        }
        ]
    },
    "editable": true,
    "fiscalYearStartMonth": 0,
    "graphTooltip": 0,
    "id": null,
    "links": [],
    "liveNow": false,
    "panels": [
        {
        "datasource": {
            "type": "prometheus",
            "uid": "PBFA97CFB590B2093"
        },
        "fieldConfig": {
            "defaults": {
            "color": {
                "mode": "palette-classic"
            },
            "custom": {
                "axisBorderShow": false,
                "axisCenteredZero": false,
                "axisColorMode": "text",
                "axisLabel": "",
                "axisPlacement": "auto",
                "barAlignment": 0,
                "drawStyle": "line",
                "fillOpacity": 0,
                "gradientMode": "none",
                "hideFrom": {
                "legend": false,
                "tooltip": false,
                "viz": false
                },
                "insertNulls": false,
                "lineInterpolation": "linear",
                "lineWidth": 1,
                "pointSize": 5,
                "scaleDistribution": {
                "type": "linear"
                },
                "showPoints": "auto",
                "spanNulls": false,
                "stacking": {
                "group": "A",
                "mode": "none"
                },
                "thresholdsStyle": {
                "mode": "off"
                }
            },
            "mappings": [],
            "thresholds": {
                "mode": "absolute",
                "steps": [
                {
                    "color": "green",
                    "value": null
                },
                {
                    "color": "red",
                    "value": 80
                }
                ]
            }
            },
            "overrides": []
        },
        "gridPos": {
            "h": 8,
            "w": 12,
            "x": 0,
            "y": 0
        },
        "id": 1,
        "options": {
            "legend": {
            "calcs": [],
            "displayMode": "list",
            "placement": "bottom",
            "showLegend": true
            },
            "tooltip": {
            "mode": "single",
            "sort": "none"
            }
        },
        "targets": [
            {
            "datasource": {
                "type": "prometheus",
                "uid": "PBFA97CFB590B2093"
            },
            "disableTextWrap": false,
            "editorMode": "builder",
            "expr": "kube_node_info",
            "fullMetaSearch": false,
            "includeNullMetadata": true,
            "instant": false,
            "legendFormat": "__auto",
            "range": true,
            "refId": "A",
            "useBackend": false
            }
        ],
        "title": "Panel Title",
        "type": "timeseries"
        }
    ],
    "refresh": "",
    "schemaVersion": 38,
    "tags": [],
    "templating": {
        "list": []
    },
    "time": {
        "from": "now-6h",
        "to": "now"
    },
    "timepicker": {},
    "timezone": "",
    "title": "New dashboard",
    "uid": null,
    "version": 1,
    "weekStart": ""
  },
  "folderUid": null,
  "message": "Made changes to xyz",
  "overwrite": false
}'
# {
#     "id": 1,
#     "slug": "new-dashboard",
#     "status": "success",
#     "uid": "a8f8605c-19a6-449f-bec1-6dde5248d889",
#     "url": "/d/a8f8605c-19a6-449f-bec1-6dde5248d889/new-dashboard",
#     "version": 1
# }

# delete
curl -X DELETE -H "Authorization: Bearer eyJrIjoiVDFqaUpvd0FuZm82dHBYRmZmTzlsbDJGTlF3d0JGVkUiLCJuIjoiYXBpX3Rva2VuIiwiaWQiOjF9" \
     -H "Content-Type: application/json" \
     http://grafana/api/dashboards/uid/a8f8605c-19a6-449f-bec1-6dde5248d889
# {
#     "id": 1,
#     "message": "Dashboard New dashboard deleted",
#     "title": "New dashboard"
# }
