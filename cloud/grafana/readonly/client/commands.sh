#!/usr/bin/env bash
# set -x             # for debug
set -euo pipefail  # fail early
SCRIPT_DIR="$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

cd "$SCRIPT_DIR"

##############################################
# Don't run. This file is a note for commands.
##############################################

go get github.com/grafana/grafana-api-golang-client@v0.26.0

kubectl port-forward svc/grafana 10080:80

# createByUid()
#
# Dashboard Title and UID must be both unique.
go run .
# Users: [{ID:1 Email:admin@localhost Name: Login:admin IsAdmin:true IsDisabled:false LastSeenAt:2023-12-07 07:44:21 +0000 UTC LastSeenAtAge:4 minutes AuthLabels:[] AvatarURL:/avatar/46d229b033af06a191ff2267bca9ae56}]
# Dashboards: [{ID:2 UID:rYdddlPWk Title:Node Exporter Full URI:db/node-exporter-full URL:/d/rYdddlPWk/node-exporter-full Slug: Type:dash-db Tags:[linux] IsStarred:false FolderID:0 FolderUID: FolderTitle: FolderURL:}]
# Created dashboard with UID my-dashboard-uid-1
# Created dashboard with UID my-dashboard-uid-2
# Dashboards: [{ID:8 UID:my-dashboard-uid-1 Title:My Dashboard by UID:my-dashboard-uid-1 URI:db/my-dashboard-by-uid3a-my-dashboard-uid-1 URL:/d/my-dashboard-uid-1/my-dashboard-by-uid3a-my-dashboard-uid-1 Slug: Type:dash-db Tags:[] IsStarred:false FolderID:0 FolderUID: FolderTitle: FolderURL:} {ID:9 UID:my-dashboard-uid-2 Title:My Dashboard by UID:my-dashboard-uid-2 URI:db/my-dashboard-by-uid3a-my-dashboard-uid-2 URL:/d/my-dashboard-uid-2/my-dashboard-by-uid3a-my-dashboard-uid-2 Slug: Type:dash-db Tags:[] IsStarred:false FolderID:0 FolderUID: FolderTitle: FolderURL:} {ID:2 UID:rYdddlPWk Title:Node Exporter Full URI:db/node-exporter-full URL:/d/rYdddlPWk/node-exporter-full Slug: Type:dash-db Tags:[linux] IsStarred:false FolderID:0 FolderUID: FolderTitle: FolderURL:}]
# Deleted dashboard my-dashboard-uid-1
# Deleted dashboard my-dashboard-uid-2
# Dashboards: [{ID:2 UID:rYdddlPWk Title:Node Exporter Full URI:db/node-exporter-full URL:/d/rYdddlPWk/node-exporter-full Slug: Type:dash-db Tags:[linux] IsStarred:false FolderID:0 FolderUID: FolderTitle: FolderURL:}]




