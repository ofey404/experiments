package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"net/url"
	"text/template"
	"time"

	client "github.com/grafana/grafana-api-golang-client"
	"github.com/zeromicro/go-zero/core/logx"
)

func main() {
	var c, err = client.New("http://localhost:10080", client.Config{
		BasicAuth:        url.UserPassword("admin", "admin"),
		NumRetries:       1,
		RetryTimeout:     time.Second,
		RetryStatusCodes: []string{"4xx", "5xx"},
	})
	logx.Must(err)

	users, err := c.Users()
	logx.Must(err)
	fmt.Printf("Users: %+v\n", users)

	dashboards, err := c.Dashboards()
	logx.Must(err)
	fmt.Printf("Dashboards: %+v\n", dashboards)

	//createByTitle(c)
	//createByUid(c)

	//checkNotFound(c)
	checkExisted(c)
}

func checkExisted(c *client.Client) {
	_, err := c.DashboardByUID("rYdddlPWk")
	logx.Must(err)
}

func checkNotFound(c *client.Client) {
	_, err := c.DashboardByUID("")
	logx.Must(err)
}

func createByUid(c *client.Client) {
	var (
		uid1 = "my-dashboard-uid-1"
		uid2 = "my-dashboard-uid-2"
	)
	_, err := c.NewDashboard(client.Dashboard{
		Model: mustLoadDashboardJson(renderDashboard(dashboardParams{
			Title: "My Dashboard by UID:" + uid1,
			Uid:   uid1,
		})),
	})
	logx.Must(err)
	fmt.Printf("Created dashboard with UID %s\n", uid1)

	_, err = c.NewDashboard(client.Dashboard{
		Model: mustLoadDashboardJson(renderDashboard(dashboardParams{
			Title: "My Dashboard by UID:" + uid2,
			Uid:   uid2,
		})),
	})
	logx.Must(err)
	fmt.Printf("Created dashboard with UID %s\n", uid2)

	dashboards, err := c.Dashboards()
	logx.Must(err)
	fmt.Printf("Dashboards: %+v\n", dashboards)

	err = c.DeleteDashboardByUID(uid1)
	logx.Must(err)
	fmt.Printf("Deleted dashboard %s\n", uid1)

	err = c.DeleteDashboardByUID(uid2)
	logx.Must(err)
	fmt.Printf("Deleted dashboard %s\n", uid2)

	dashboards, err = c.Dashboards()
	logx.Must(err)
	fmt.Printf("Dashboards: %+v\n", dashboards)
}

func createByTitle(c *client.Client) {
	resp, err := c.NewDashboard(client.Dashboard{
		Model: mustLoadDashboardJson(renderDashboard(dashboardParams{
			Title: "My Dashboard",
		})),
	})
	logx.Must(err)
	uid := resp.UID
	fmt.Printf("Created dashboard %s\n", uid)

	d, err := c.DashboardByUID(uid)
	logx.Must(err)
	fmt.Printf("New dashboard's URL = %s\n", d.Meta.URL)

	dashboards, err := c.Dashboards()
	logx.Must(err)
	fmt.Printf("Dashboards: %+v\n", dashboards)

	err = c.DeleteDashboardByUID(uid)
	logx.Must(err)
	fmt.Printf("Deleted dashboard %s\n", uid)
}

func mustLoadDashboardJson(s string) map[string]interface{} {
	var data map[string]interface{}
	err := json.Unmarshal([]byte(s), &data)
	logx.Must(err)
	return data
}

type dashboardParams struct {
	Title string
	Uid   string
}

func renderDashboard(p dashboardParams) string {
	tmpl, err := template.New("dashboard").Parse(`{
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
    "title": "{{.Title}}",
    "uid": "{{.Uid}}",
    "version": 1,
    "weekStart": ""
}`)
	logx.Must(err)

	var buf bytes.Buffer
	err = tmpl.Execute(&buf, p)
	logx.Must(err)

	return buf.String()
}
