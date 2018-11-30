{{/*
  Licensed Materials - Property of IBM
  5737-E67
  @ Copyright IBM Corporation 2016, 2018. All Rights Reserved.
  US Government Users Restricted Rights - Use, duplication or disclosure restricted by GSA ADP Schedule Contract with IBM Corp.
*/}}

{{/* Kubernetes Monitoring Dashboard File */}}
{{/* origin: https://grafana.com/dashboards/1621 */}}
{{- define "kubernetesMonitoring" }}
kubernetes-cluster-monitoring.json: |-
    {
      "__inputs": [
        {
          "name": "DS_PROMETHEUS",
          "label": "Prometheus",
          "description": "",
          "type": "datasource",
          "pluginId": "prometheus",
          "pluginName": "Prometheus"
        }
      ],
      "__requires": [
        {
          "type": "panel",
          "id": "graph",
          "name": "Graph",
          "version": ""
        },
        {
          "type": "panel",
          "id": "singlestat",
          "name": "Singlestat",
          "version": ""
        },
        {
          "type": "grafana",
          "id": "grafana",
          "name": "Grafana",
          "version": "3.1.1"
        },
        {
          "type": "datasource",
          "id": "prometheus",
          "name": "Prometheus",
          "version": "1.3.0"
        }
      ],
      "id": null,
      "title": "Kubernetes: Cluster Monitoring",
      "description": "Monitors Kubernetes cluster using Prometheus. Shows overall cluster CPU / Memory / Filesystem usage as well as individual pod, containers, systemd services statistics. Uses cAdvisor metrics only.",
      "tags": [
        "kubernetes"
      ],
      "style": "dark",
      "timezone": "browser",
      "editable": true,
      "hideControls": false,
      "sharedCrosshair": false,
      "rows": [
        {
          "collapse": false,
          "editable": true,
          "height": "200px",
          "panels": [
            {
              "aliasColors": {},
              "bars": false,
              "datasource": "prometheus",
              "decimals": 2,
              "editable": true,
              "error": false,
              "fill": 1,
              "grid": {
                "threshold1": null,
                "threshold1Color": "rgba(216, 200, 27, 0.27)",
                "threshold2": null,
                "threshold2Color": "rgba(234, 112, 112, 0.22)",
                "thresholdLine": false
              },
              "height": "200px",
              "id": 32,
              "isNew": true,
              "legend": {
                "alignAsTable": false,
                "avg": true,
                "current": true,
                "max": false,
                "min": false,
                "rightSide": false,
                "show": false,
                "sideWidth": 200,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 2,
              "links": [],
              "nullPointMode": "connected",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "span": 12,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "sum (rate (container_network_receive_bytes_total{kubernetes_io_hostname=~\"^$Node$\"}[5m]))",
                  "interval": "10s",
                  "intervalFactor": 1,
                  "legendFormat": "Received",
                  "metric": "network",
                  "refId": "A",
                  "step": 10
                },
                {
                  "expr": "- sum (rate (container_network_transmit_bytes_total{kubernetes_io_hostname=~\"^$Node$\"}[5m]))",
                  "interval": "10s",
                  "intervalFactor": 1,
                  "legendFormat": "Sent",
                  "metric": "network",
                  "refId": "B",
                  "step": 10
                }
              ],
              "timeFrom": null,
              "timeShift": null,
              "title": "Network I/O pressure",
              "tooltip": {
                "msResolution": false,
                "shared": true,
                "sort": 0,
                "value_type": "cumulative"
              },
              "transparent": false,
              "type": "graph",
              "xaxis": {
                "show": true
              },
              "yaxes": [
                {
                  "format": "Bps",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "Bps",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            }
          ],
          "title": "Network I/O pressure"
        },
        {
          "collapse": false,
          "editable": true,
          "height": "250px",
          "panels": [
            {
              "cacheTimeout": null,
              "colorBackground": false,
              "colorValue": true,
              "colors": [
                "rgba(50, 172, 45, 0.97)",
                "rgba(237, 129, 40, 0.89)",
                "rgba(245, 54, 54, 0.9)"
              ],
              "datasource": "prometheus",
              "editable": true,
              "error": false,
              "format": "percent",
              "gauge": {
                "maxValue": 100,
                "minValue": 0,
                "show": true,
                "thresholdLabels": false,
                "thresholdMarkers": true
              },
              "height": "180px",
              "id": 4,
              "interval": null,
              "isNew": true,
              "links": [],
              "mappingType": 1,
              "mappingTypes": [
                {
                  "name": "value to text",
                  "value": 1
                },
                {
                  "name": "range to text",
                  "value": 2
                }
              ],
              "maxDataPoints": 100,
              "nullPointMode": "connected",
              "nullText": null,
              "postfix": "",
              "postfixFontSize": "50%",
              "prefix": "",
              "prefixFontSize": "50%",
              "rangeMaps": [
                {
                  "from": "null",
                  "text": "N/A",
                  "to": "null"
                }
              ],
              "span": 4,
              "sparkline": {
                "fillColor": "rgba(31, 118, 189, 0.18)",
                "full": false,
                "lineColor": "rgb(31, 120, 193)",
                "show": false
              },
              "targets": [
                {
                  "expr": "sum (container_memory_working_set_bytes{id=\"/\",kubernetes_io_hostname=~\"^$Node$\"}) / sum (machine_memory_bytes{kubernetes_io_hostname=~\"^$Node$\"}) * 100",
                  "interval": "10s",
                  "intervalFactor": 1,
                  "refId": "A",
                  "step": 10
                }
              ],
              "thresholds": "65, 90",
              "title": "Cluster memory usage",
              "transparent": false,
              "type": "singlestat",
              "valueFontSize": "80%",
              "valueMaps": [
                {
                  "op": "=",
                  "text": "N/A",
                  "value": "null"
                }
              ],
              "valueName": "current"
            },
            {
              "cacheTimeout": null,
              "colorBackground": false,
              "colorValue": true,
              "colors": [
                "rgba(50, 172, 45, 0.97)",
                "rgba(237, 129, 40, 0.89)",
                "rgba(245, 54, 54, 0.9)"
              ],
              "datasource": "prometheus",
              "decimals": 2,
              "editable": true,
              "error": false,
              "format": "percent",
              "gauge": {
                "maxValue": 100,
                "minValue": 0,
                "show": true,
                "thresholdLabels": false,
                "thresholdMarkers": true
              },
              "height": "180px",
              "id": 6,
              "interval": null,
              "isNew": true,
              "links": [],
              "mappingType": 1,
              "mappingTypes": [
                {
                  "name": "value to text",
                  "value": 1
                },
                {
                  "name": "range to text",
                  "value": 2
                }
              ],
              "maxDataPoints": 100,
              "nullPointMode": "connected",
              "nullText": null,
              "postfix": "",
              "postfixFontSize": "50%",
              "prefix": "",
              "prefixFontSize": "50%",
              "rangeMaps": [
                {
                  "from": "null",
                  "text": "N/A",
                  "to": "null"
                }
              ],
              "span": 4,
              "sparkline": {
                "fillColor": "rgba(31, 118, 189, 0.18)",
                "full": false,
                "lineColor": "rgb(31, 120, 193)",
                "show": false
              },
              "targets": [
                {
                  "expr": "sum (rate (container_cpu_usage_seconds_total{id=\"/\",kubernetes_io_hostname=~\"^$Node$\"}[5m])) / sum (machine_cpu_cores{kubernetes_io_hostname=~\"^$Node$\"}) * 100",
                  "interval": "10s",
                  "intervalFactor": 1,
                  "refId": "A",
                  "step": 10
                }
              ],
              "thresholds": "65, 90",
              "title": "Cluster CPU usage (5m avg)",
              "type": "singlestat",
              "valueFontSize": "80%",
              "valueMaps": [
                {
                  "op": "=",
                  "text": "N/A",
                  "value": "null"
                }
              ],
              "valueName": "current"
            },
            {
              "cacheTimeout": null,
              "colorBackground": false,
              "colorValue": true,
              "colors": [
                "rgba(50, 172, 45, 0.97)",
                "rgba(237, 129, 40, 0.89)",
                "rgba(245, 54, 54, 0.9)"
              ],
              "datasource": "prometheus",
              "decimals": 2,
              "editable": true,
              "error": false,
              "format": "percent",
              "gauge": {
                "maxValue": 100,
                "minValue": 0,
                "show": true,
                "thresholdLabels": false,
                "thresholdMarkers": true
              },
              "height": "180px",
              "id": 7,
              "interval": null,
              "isNew": true,
              "links": [],
              "mappingType": 1,
              "mappingTypes": [
                {
                  "name": "value to text",
                  "value": 1
                },
                {
                  "name": "range to text",
                  "value": 2
                }
              ],
              "maxDataPoints": 100,
              "nullPointMode": "connected",
              "nullText": null,
              "postfix": "",
              "postfixFontSize": "50%",
              "prefix": "",
              "prefixFontSize": "50%",
              "rangeMaps": [
                {
                  "from": "null",
                  "text": "N/A",
                  "to": "null"
                }
              ],
              "span": 4,
              "sparkline": {
                "fillColor": "rgba(31, 118, 189, 0.18)",
                "full": false,
                "lineColor": "rgb(31, 120, 193)",
                "show": false
              },
              "targets": [
                {
                  "expr": "sum (container_fs_usage_bytes{device=~\"^/dev/[sv]da[1-9]$\",id=\"/\",kubernetes_io_hostname=~\"^$Node$\"}) / sum (container_fs_limit_bytes{device=~\"^/dev/[sv]da[1-9]$\",id=\"/\",kubernetes_io_hostname=~\"^$Node$\"}) * 100",
                  "interval": "10s",
                  "intervalFactor": 1,
                  "legendFormat": "",
                  "metric": "",
                  "refId": "A",
                  "step": 10
                }
              ],
              "thresholds": "65, 90",
              "title": "Cluster filesystem usage",
              "type": "singlestat",
              "valueFontSize": "80%",
              "valueMaps": [
                {
                  "op": "=",
                  "text": "N/A",
                  "value": "null"
                }
              ],
              "valueName": "current"
            },
            {
              "cacheTimeout": null,
              "colorBackground": false,
              "colorValue": false,
              "colors": [
                "rgba(50, 172, 45, 0.97)",
                "rgba(237, 129, 40, 0.89)",
                "rgba(245, 54, 54, 0.9)"
              ],
              "datasource": "prometheus",
              "decimals": 2,
              "editable": true,
              "error": false,
              "format": "bytes",
              "gauge": {
                "maxValue": 100,
                "minValue": 0,
                "show": false,
                "thresholdLabels": false,
                "thresholdMarkers": true
              },
              "height": "1px",
              "id": 9,
              "interval": null,
              "isNew": true,
              "links": [],
              "mappingType": 1,
              "mappingTypes": [
                {
                  "name": "value to text",
                  "value": 1
                },
                {
                  "name": "range to text",
                  "value": 2
                }
              ],
              "maxDataPoints": 100,
              "nullPointMode": "connected",
              "nullText": null,
              "postfix": "",
              "postfixFontSize": "20%",
              "prefix": "",
              "prefixFontSize": "20%",
              "rangeMaps": [
                {
                  "from": "null",
                  "text": "N/A",
                  "to": "null"
                }
              ],
              "span": 2,
              "sparkline": {
                "fillColor": "rgba(31, 118, 189, 0.18)",
                "full": false,
                "lineColor": "rgb(31, 120, 193)",
                "show": false
              },
              "targets": [
                {
                  "expr": "sum (container_memory_working_set_bytes{id=\"/\",kubernetes_io_hostname=~\"^$Node$\"})",
                  "interval": "10s",
                  "intervalFactor": 1,
                  "refId": "A",
                  "step": 10
                }
              ],
              "thresholds": "",
              "title": "Used",
              "type": "singlestat",
              "valueFontSize": "50%",
              "valueMaps": [
                {
                  "op": "=",
                  "text": "N/A",
                  "value": "null"
                }
              ],
              "valueName": "current"
            },
            {
              "cacheTimeout": null,
              "colorBackground": false,
              "colorValue": false,
              "colors": [
                "rgba(50, 172, 45, 0.97)",
                "rgba(237, 129, 40, 0.89)",
                "rgba(245, 54, 54, 0.9)"
              ],
              "datasource": "prometheus",
              "decimals": 2,
              "editable": true,
              "error": false,
              "format": "bytes",
              "gauge": {
                "maxValue": 100,
                "minValue": 0,
                "show": false,
                "thresholdLabels": false,
                "thresholdMarkers": true
              },
              "height": "1px",
              "id": 10,
              "interval": null,
              "isNew": true,
              "links": [],
              "mappingType": 1,
              "mappingTypes": [
                {
                  "name": "value to text",
                  "value": 1
                },
                {
                  "name": "range to text",
                  "value": 2
                }
              ],
              "maxDataPoints": 100,
              "nullPointMode": "connected",
              "nullText": null,
              "postfix": "",
              "postfixFontSize": "50%",
              "prefix": "",
              "prefixFontSize": "50%",
              "rangeMaps": [
                {
                  "from": "null",
                  "text": "N/A",
                  "to": "null"
                }
              ],
              "span": 2,
              "sparkline": {
                "fillColor": "rgba(31, 118, 189, 0.18)",
                "full": false,
                "lineColor": "rgb(31, 120, 193)",
                "show": false
              },
              "targets": [
                {
                  "expr": "sum (machine_memory_bytes{kubernetes_io_hostname=~\"^$Node$\"})",
                  "interval": "10s",
                  "intervalFactor": 1,
                  "refId": "A",
                  "step": 10
                }
              ],
              "thresholds": "",
              "title": "Total",
              "type": "singlestat",
              "valueFontSize": "50%",
              "valueMaps": [
                {
                  "op": "=",
                  "text": "N/A",
                  "value": "null"
                }
              ],
              "valueName": "current"
            },
            {
              "cacheTimeout": null,
              "colorBackground": false,
              "colorValue": false,
              "colors": [
                "rgba(50, 172, 45, 0.97)",
                "rgba(237, 129, 40, 0.89)",
                "rgba(245, 54, 54, 0.9)"
              ],
              "datasource": "prometheus",
              "decimals": 2,
              "editable": true,
              "error": false,
              "format": "none",
              "gauge": {
                "maxValue": 100,
                "minValue": 0,
                "show": false,
                "thresholdLabels": false,
                "thresholdMarkers": true
              },
              "height": "1px",
              "id": 11,
              "interval": null,
              "isNew": true,
              "links": [],
              "mappingType": 1,
              "mappingTypes": [
                {
                  "name": "value to text",
                  "value": 1
                },
                {
                  "name": "range to text",
                  "value": 2
                }
              ],
              "maxDataPoints": 100,
              "nullPointMode": "connected",
              "nullText": null,
              "postfix": " cores",
              "postfixFontSize": "30%",
              "prefix": "",
              "prefixFontSize": "50%",
              "rangeMaps": [
                {
                  "from": "null",
                  "text": "N/A",
                  "to": "null"
                }
              ],
              "span": 2,
              "sparkline": {
                "fillColor": "rgba(31, 118, 189, 0.18)",
                "full": false,
                "lineColor": "rgb(31, 120, 193)",
                "show": false
              },
              "targets": [
                {
                  "expr": "sum (rate (container_cpu_usage_seconds_total{id=\"/\",kubernetes_io_hostname=~\"^$Node$\"}[5m]))",
                  "interval": "10s",
                  "intervalFactor": 1,
                  "refId": "A",
                  "step": 10
                }
              ],
              "thresholds": "",
              "title": "Used",
              "type": "singlestat",
              "valueFontSize": "50%",
              "valueMaps": [
                {
                  "op": "=",
                  "text": "N/A",
                  "value": "null"
                }
              ],
              "valueName": "current"
            },
            {
              "cacheTimeout": null,
              "colorBackground": false,
              "colorValue": false,
              "colors": [
                "rgba(50, 172, 45, 0.97)",
                "rgba(237, 129, 40, 0.89)",
                "rgba(245, 54, 54, 0.9)"
              ],
              "datasource": "prometheus",
              "decimals": 2,
              "editable": true,
              "error": false,
              "format": "none",
              "gauge": {
                "maxValue": 100,
                "minValue": 0,
                "show": false,
                "thresholdLabels": false,
                "thresholdMarkers": true
              },
              "height": "1px",
              "id": 12,
              "interval": null,
              "isNew": true,
              "links": [],
              "mappingType": 1,
              "mappingTypes": [
                {
                  "name": "value to text",
                  "value": 1
                },
                {
                  "name": "range to text",
                  "value": 2
                }
              ],
              "maxDataPoints": 100,
              "nullPointMode": "connected",
              "nullText": null,
              "postfix": " cores",
              "postfixFontSize": "30%",
              "prefix": "",
              "prefixFontSize": "50%",
              "rangeMaps": [
                {
                  "from": "null",
                  "text": "N/A",
                  "to": "null"
                }
              ],
              "span": 2,
              "sparkline": {
                "fillColor": "rgba(31, 118, 189, 0.18)",
                "full": false,
                "lineColor": "rgb(31, 120, 193)",
                "show": false
              },
              "targets": [
                {
                  "expr": "sum (machine_cpu_cores{kubernetes_io_hostname=~\"^$Node$\"})",
                  "interval": "10s",
                  "intervalFactor": 1,
                  "refId": "A",
                  "step": 10
                }
              ],
              "thresholds": "",
              "title": "Total",
              "type": "singlestat",
              "valueFontSize": "50%",
              "valueMaps": [
                {
                  "op": "=",
                  "text": "N/A",
                  "value": "null"
                }
              ],
              "valueName": "current"
            },
            {
              "cacheTimeout": null,
              "colorBackground": false,
              "colorValue": false,
              "colors": [
                "rgba(50, 172, 45, 0.97)",
                "rgba(237, 129, 40, 0.89)",
                "rgba(245, 54, 54, 0.9)"
              ],
              "datasource": "prometheus",
              "decimals": 2,
              "editable": true,
              "error": false,
              "format": "bytes",
              "gauge": {
                "maxValue": 100,
                "minValue": 0,
                "show": false,
                "thresholdLabels": false,
                "thresholdMarkers": true
              },
              "height": "1px",
              "id": 13,
              "interval": null,
              "isNew": true,
              "links": [],
              "mappingType": 1,
              "mappingTypes": [
                {
                  "name": "value to text",
                  "value": 1
                },
                {
                  "name": "range to text",
                  "value": 2
                }
              ],
              "maxDataPoints": 100,
              "nullPointMode": "connected",
              "nullText": null,
              "postfix": "",
              "postfixFontSize": "50%",
              "prefix": "",
              "prefixFontSize": "50%",
              "rangeMaps": [
                {
                  "from": "null",
                  "text": "N/A",
                  "to": "null"
                }
              ],
              "span": 2,
              "sparkline": {
                "fillColor": "rgba(31, 118, 189, 0.18)",
                "full": false,
                "lineColor": "rgb(31, 120, 193)",
                "show": false
              },
              "targets": [
                {
                  "expr": "sum (container_fs_usage_bytes{device=~\"^/dev/[sv]da[1-9]$\",id=\"/\",kubernetes_io_hostname=~\"^$Node$\"})",
                  "interval": "10s",
                  "intervalFactor": 1,
                  "refId": "A",
                  "step": 10
                }
              ],
              "thresholds": "",
              "title": "Used",
              "type": "singlestat",
              "valueFontSize": "50%",
              "valueMaps": [
                {
                  "op": "=",
                  "text": "N/A",
                  "value": "null"
                }
              ],
              "valueName": "current"
            },
            {
              "cacheTimeout": null,
              "colorBackground": false,
              "colorValue": false,
              "colors": [
                "rgba(50, 172, 45, 0.97)",
                "rgba(237, 129, 40, 0.89)",
                "rgba(245, 54, 54, 0.9)"
              ],
              "datasource": "prometheus",
              "decimals": 2,
              "editable": true,
              "error": false,
              "format": "bytes",
              "gauge": {
                "maxValue": 100,
                "minValue": 0,
                "show": false,
                "thresholdLabels": false,
                "thresholdMarkers": true
              },
              "height": "1px",
              "id": 14,
              "interval": null,
              "isNew": true,
              "links": [],
              "mappingType": 1,
              "mappingTypes": [
                {
                  "name": "value to text",
                  "value": 1
                },
                {
                  "name": "range to text",
                  "value": 2
                }
              ],
              "maxDataPoints": 100,
              "nullPointMode": "connected",
              "nullText": null,
              "postfix": "",
              "postfixFontSize": "50%",
              "prefix": "",
              "prefixFontSize": "50%",
              "rangeMaps": [
                {
                  "from": "null",
                  "text": "N/A",
                  "to": "null"
                }
              ],
              "span": 2,
              "sparkline": {
                "fillColor": "rgba(31, 118, 189, 0.18)",
                "full": false,
                "lineColor": "rgb(31, 120, 193)",
                "show": false
              },
              "targets": [
                {
                  "expr": "sum (container_fs_limit_bytes{device=~\"^/dev/[sv]da[1-9]$\",id=\"/\",kubernetes_io_hostname=~\"^$Node$\"})",
                  "interval": "10s",
                  "intervalFactor": 1,
                  "refId": "A",
                  "step": 10
                }
              ],
              "thresholds": "",
              "title": "Total",
              "type": "singlestat",
              "valueFontSize": "50%",
              "valueMaps": [
                {
                  "op": "=",
                  "text": "N/A",
                  "value": "null"
                }
              ],
              "valueName": "current"
            }
          ],
          "showTitle": false,
          "title": "Total usage"
        },
        {
          "collapse": true,
          "editable": true,
          "height": "250px",
          "panels": [
            {
              "aliasColors": {},
              "bars": false,
              "datasource": "prometheus",
              "decimals": 3,
              "editable": true,
              "error": false,
              "fill": 0,
              "grid": {
                "threshold1": null,
                "threshold1Color": "rgba(216, 200, 27, 0.27)",
                "threshold2": null,
                "threshold2Color": "rgba(234, 112, 112, 0.22)"
              },
              "height": "",
              "id": 24,
              "isNew": true,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "hideEmpty": false,
                "hideZero": false,
                "max": false,
                "min": false,
                "rightSide": true,
                "show": true,
                "sideWidth": null,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 2,
              "links": [],
              "nullPointMode": "connected",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "span": 12,
              "stack": false,
              "steppedLine": true,
              "targets": [
                {
                  "expr": "sum (rate (container_cpu_usage_seconds_total{image!=\"\",name=~\"^k8s_.*\",container_name!=\"POD\",kubernetes_io_hostname=~\"^$Node$\"}[5m])) by (container_name, pod_name)",
                  "hide": false,
                  "interval": "10s",
                  "intervalFactor": 1,
                  "legendFormat": "pod: {{ "{{" }} pod_name {{ "}}" }} | {{ "{{" }} container_name {{ "}}" }}",
                  "metric": "container_cpu",
                  "refId": "A",
                  "step": 10
                },
                {
                  "expr": "sum (rate (container_cpu_usage_seconds_total{image!=\"\",name!~\"^k8s_.*\",kubernetes_io_hostname=~\"^$Node$\"}[5m])) by (kubernetes_io_hostname, name, image)",
                  "hide": false,
                  "interval": "10s",
                  "intervalFactor": 1,
                  "legendFormat": "docker: {{ "{{" }} kubernetes_io_hostname {{ "}}" }} | {{ "{{" }} image {{ "}}" }} ({{ "{{" }} name {{ "}}" }})",
                  "metric": "container_cpu",
                  "refId": "B",
                  "step": 10
                },
                {
                  "expr": "sum (rate (container_cpu_usage_seconds_total{rkt_container_name!=\"\",kubernetes_io_hostname=~\"^$Node$\"}[5m])) by (kubernetes_io_hostname, rkt_container_name)",
                  "interval": "10s",
                  "intervalFactor": 1,
                  "legendFormat": "rkt: {{ "{{" }} kubernetes_io_hostname {{ "}}" }} | {{ "{{" }} rkt_container_name {{ "}}" }}",
                  "metric": "container_cpu",
                  "refId": "C",
                  "step": 10
                }
              ],
              "timeFrom": null,
              "timeShift": null,
              "title": "Containers CPU usage (5m avg)",
              "tooltip": {
                "msResolution": true,
                "shared": true,
                "sort": 2,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "show": true
              },
              "yaxes": [
                {
                  "format": "none",
                  "label": "cores",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            }
          ],
          "title": "Containers CPU usage"
        },
        {
          "collapse": true,
          "editable": true,
          "height": "500px",
          "panels": [
            {
              "aliasColors": {},
              "bars": false,
              "datasource": "prometheus",
              "decimals": 3,
              "editable": true,
              "error": false,
              "fill": 0,
              "grid": {
                "threshold1": null,
                "threshold1Color": "rgba(216, 200, 27, 0.27)",
                "threshold2": null,
                "threshold2Color": "rgba(234, 112, 112, 0.22)"
              },
              "id": 20,
              "isNew": true,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": false,
                "min": false,
                "rightSide": false,
                "show": true,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 2,
              "links": [],
              "nullPointMode": "connected",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "span": 12,
              "stack": false,
              "steppedLine": true,
              "targets": [
                {
                  "expr": "sum (rate (container_cpu_usage_seconds_total{id!=\"/\",kubernetes_io_hostname=~\"^$Node$\"}[5m])) by (id)",
                  "hide": false,
                  "interval": "10s",
                  "intervalFactor": 1,
                  "legendFormat": "{{ "{{" }} id {{ "}}" }}",
                  "metric": "container_cpu",
                  "refId": "A",
                  "step": 10
                }
              ],
              "timeFrom": null,
              "timeShift": null,
              "title": "All processes CPU usage (5m avg)",
              "tooltip": {
                "msResolution": true,
                "shared": true,
                "sort": 2,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "show": true
              },
              "yaxes": [
                {
                  "format": "none",
                  "label": "cores",
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            }
          ],
          "repeat": null,
          "showTitle": false,
          "title": "All processes CPU usage"
        },
        {
          "collapse": true,
          "editable": true,
          "height": "250px",
          "panels": [
            {
              "aliasColors": {},
              "bars": false,
              "datasource": "prometheus",
              "decimals": 2,
              "editable": true,
              "error": false,
              "fill": 0,
              "grid": {
                "threshold1": null,
                "threshold1Color": "rgba(216, 200, 27, 0.27)",
                "threshold2": null,
                "threshold2Color": "rgba(234, 112, 112, 0.22)"
              },
              "id": 27,
              "isNew": true,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": false,
                "min": false,
                "rightSide": true,
                "show": true,
                "sideWidth": 200,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 2,
              "links": [],
              "nullPointMode": "connected",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "span": 12,
              "stack": false,
              "steppedLine": true,
              "targets": [
                {
                  "expr": "sum (container_memory_working_set_bytes{image!=\"\",name=~\"^k8s_.*\",container_name!=\"POD\",kubernetes_io_hostname=~\"^$Node$\"}) by (container_name, pod_name)",
                  "interval": "10s",
                  "intervalFactor": 1,
                  "legendFormat": "pod: {{ "{{" }} pod_name {{ "}}" }} | {{ "{{" }} container_name {{ "}}" }}",
                  "metric": "container_memory_usage:sort_desc",
                  "refId": "A",
                  "step": 10
                },
                {
                  "expr": "sum (container_memory_working_set_bytes{image!=\"\",name!~\"^k8s_.*\",kubernetes_io_hostname=~\"^$Node$\"}) by (kubernetes_io_hostname, name, image)",
                  "interval": "10s",
                  "intervalFactor": 1,
                  "legendFormat": "docker: {{ "{{" }} kubernetes_io_hostname {{ "}}" }} | {{ "{{" }} image {{ "}}" }} ({{ "{{" }} name {{ "}}" }})",
                  "metric": "container_memory_usage:sort_desc",
                  "refId": "B",
                  "step": 10
                },
                {
                  "expr": "sum (container_memory_working_set_bytes{rkt_container_name!=\"\",kubernetes_io_hostname=~\"^$Node$\"}) by (kubernetes_io_hostname, rkt_container_name)",
                  "interval": "10s",
                  "intervalFactor": 1,
                  "legendFormat": "rkt: {{ "{{" }} kubernetes_io_hostname {{ "}}" }} | {{ "{{" }} rkt_container_name {{ "}}" }}",
                  "metric": "container_memory_usage:sort_desc",
                  "refId": "C",
                  "step": 10
                }
              ],
              "timeFrom": null,
              "timeShift": null,
              "title": "Containers memory usage",
              "tooltip": {
                "msResolution": false,
                "shared": true,
                "sort": 2,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "show": true
              },
              "yaxes": [
                {
                  "format": "bytes",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            }
          ],
          "title": "Containers memory usage"
        },
        {
          "collapse": true,
          "editable": true,
          "height": "500px",
          "panels": [
            {
              "aliasColors": {},
              "bars": false,
              "datasource": "prometheus",
              "decimals": 2,
              "editable": true,
              "error": false,
              "fill": 0,
              "grid": {
                "threshold1": null,
                "threshold1Color": "rgba(216, 200, 27, 0.27)",
                "threshold2": null,
                "threshold2Color": "rgba(234, 112, 112, 0.22)"
              },
              "id": 28,
              "isNew": true,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": false,
                "min": false,
                "rightSide": false,
                "show": true,
                "sideWidth": 200,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 2,
              "links": [],
              "nullPointMode": "connected",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "span": 12,
              "stack": false,
              "steppedLine": true,
              "targets": [
                {
                  "expr": "sum (container_memory_working_set_bytes{id!=\"/\",kubernetes_io_hostname=~\"^$Node$\"}) by (id)",
                  "interval": "10s",
                  "intervalFactor": 1,
                  "legendFormat": "{{ "{{" }} id {{ "}}" }}",
                  "metric": "container_memory_usage:sort_desc",
                  "refId": "A",
                  "step": 10
                }
              ],
              "timeFrom": null,
              "timeShift": null,
              "title": "All processes memory usage",
              "tooltip": {
                "msResolution": false,
                "shared": true,
                "sort": 2,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "show": true
              },
              "yaxes": [
                {
                  "format": "bytes",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            }
          ],
          "title": "All processes memory usage"
        },
        {
          "collapse": true,
          "editable": true,
          "height": "250px",
          "panels": [
            {
              "aliasColors": {},
              "bars": false,
              "datasource": "prometheus",
              "decimals": 2,
              "editable": true,
              "error": false,
              "fill": 1,
              "grid": {
                "threshold1": null,
                "threshold1Color": "rgba(216, 200, 27, 0.27)",
                "threshold2": null,
                "threshold2Color": "rgba(234, 112, 112, 0.22)"
              },
              "id": 30,
              "isNew": true,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": false,
                "min": false,
                "rightSide": true,
                "show": true,
                "sideWidth": 200,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 2,
              "links": [],
              "nullPointMode": "connected",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "span": 12,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "sum (rate (container_network_receive_bytes_total{image!=\"\",name=~\"^k8s_.*\",kubernetes_io_hostname=~\"^$Node$\"}[5m])) by (container_name, pod_name)",
                  "hide": false,
                  "interval": "10s",
                  "intervalFactor": 1,
                  "legendFormat": "-> pod: {{ "{{" }} pod_name {{ "}}" }} | {{ "{{" }} container_name {{ "}}" }}",
                  "metric": "network",
                  "refId": "B",
                  "step": 10
                },
                {
                  "expr": "- sum (rate (container_network_transmit_bytes_total{image!=\"\",name=~\"^k8s_.*\",kubernetes_io_hostname=~\"^$Node$\"}[5m])) by (container_name, pod_name)",
                  "hide": false,
                  "interval": "10s",
                  "intervalFactor": 1,
                  "legendFormat": "<- pod: {{ "{{" }} pod_name {{ "}}" }} | {{ "{{" }} container_name {{ "}}" }}",
                  "metric": "network",
                  "refId": "D",
                  "step": 10
                },
                {
                  "expr": "sum (rate (container_network_receive_bytes_total{image!=\"\",name!~\"^k8s_.*\",kubernetes_io_hostname=~\"^$Node$\"}[5m])) by (kubernetes_io_hostname, name, image)",
                  "hide": false,
                  "interval": "10s",
                  "intervalFactor": 1,
                  "legendFormat": "-> docker: {{ "{{" }} kubernetes_io_hostname {{ "}}" }} | {{ "{{" }} image {{ "}}" }} ({{ "{{" }} name {{ "}}" }})",
                  "metric": "network",
                  "refId": "A",
                  "step": 10
                },
                {
                  "expr": "- sum (rate (container_network_transmit_bytes_total{image!=\"\",name!~\"^k8s_.*\",kubernetes_io_hostname=~\"^$Node$\"}[5m])) by (kubernetes_io_hostname, name, image)",
                  "hide": false,
                  "interval": "10s",
                  "intervalFactor": 1,
                  "legendFormat": "<- docker: {{ "{{" }} kubernetes_io_hostname {{ "}}" }} | {{ "{{" }} image {{ "}}" }} ({{ "{{" }} name {{ "}}" }})",
                  "metric": "network",
                  "refId": "C",
                  "step": 10
                },
                {
                  "expr": "sum (rate (container_network_transmit_bytes_total{rkt_container_name!=\"\",kubernetes_io_hostname=~\"^$Node$\"}[5m])) by (kubernetes_io_hostname, rkt_container_name)",
                  "hide": false,
                  "interval": "10s",
                  "intervalFactor": 1,
                  "legendFormat": "-> rkt: {{ "{{" }} kubernetes_io_hostname {{ "}}" }} | {{ "{{" }} rkt_container_name {{ "}}" }}",
                  "metric": "network",
                  "refId": "E",
                  "step": 10
                },
                {
                  "expr": "- sum (rate (container_network_transmit_bytes_total{rkt_container_name!=\"\",kubernetes_io_hostname=~\"^$Node$\"}[5m])) by (kubernetes_io_hostname, rkt_container_name)",
                  "hide": false,
                  "interval": "10s",
                  "intervalFactor": 1,
                  "legendFormat": "<- rkt: {{ "{{" }} kubernetes_io_hostname {{ "}}" }} | {{ "{{" }} rkt_container_name {{ "}}" }}",
                  "metric": "network",
                  "refId": "F",
                  "step": 10
                }
              ],
              "timeFrom": null,
              "timeShift": null,
              "title": "Containers network I/O (5m avg)",
              "tooltip": {
                "msResolution": false,
                "shared": true,
                "sort": 2,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "show": true
              },
              "yaxes": [
                {
                  "format": "Bps",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            }
          ],
          "title": "Containers network I/O"
        },
        {
          "collapse": true,
          "editable": true,
          "height": "500px",
          "panels": [
            {
              "aliasColors": {},
              "bars": false,
              "datasource": "prometheus",
              "decimals": 2,
              "editable": true,
              "error": false,
              "fill": 1,
              "grid": {
                "threshold1": null,
                "threshold1Color": "rgba(216, 200, 27, 0.27)",
                "threshold2": null,
                "threshold2Color": "rgba(234, 112, 112, 0.22)"
              },
              "id": 29,
              "isNew": true,
              "legend": {
                "alignAsTable": true,
                "avg": true,
                "current": true,
                "max": false,
                "min": false,
                "rightSide": false,
                "show": true,
                "sideWidth": 200,
                "sort": "current",
                "sortDesc": true,
                "total": false,
                "values": true
              },
              "lines": true,
              "linewidth": 2,
              "links": [],
              "nullPointMode": "connected",
              "percentage": false,
              "pointradius": 5,
              "points": false,
              "renderer": "flot",
              "seriesOverrides": [],
              "span": 12,
              "stack": false,
              "steppedLine": false,
              "targets": [
                {
                  "expr": "sum (rate (container_network_receive_bytes_total{id!=\"/\",kubernetes_io_hostname=~\"^$Node$\"}[5m])) by (id)",
                  "interval": "10s",
                  "intervalFactor": 1,
                  "legendFormat": "-> {{ "{{" }} id {{ "}}" }}",
                  "metric": "network",
                  "refId": "A",
                  "step": 10
                },
                {
                  "expr": "- sum (rate (container_network_transmit_bytes_total{id!=\"/\",kubernetes_io_hostname=~\"^$Node$\"}[5m])) by (id)",
                  "interval": "10s",
                  "intervalFactor": 1,
                  "legendFormat": "<- {{ "{{" }} id {{ "}}" }}",
                  "metric": "network",
                  "refId": "B",
                  "step": 10
                }
              ],
              "timeFrom": null,
              "timeShift": null,
              "title": "All processes network I/O (5m avg)",
              "tooltip": {
                "msResolution": false,
                "shared": true,
                "sort": 2,
                "value_type": "cumulative"
              },
              "type": "graph",
              "xaxis": {
                "show": true
              },
              "yaxes": [
                {
                  "format": "Bps",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": true
                },
                {
                  "format": "short",
                  "label": null,
                  "logBase": 1,
                  "max": null,
                  "min": null,
                  "show": false
                }
              ]
            }
          ],
          "title": "All processes network I/O"
        }
      ],
      "time": {
        "from": "now-5m",
        "to": "now"
      },
      "timepicker": {
        "refresh_intervals": [
          "5s",
          "10s",
          "30s",
          "1m",
          "5m",
          "15m",
          "30m",
          "1h",
          "2h",
          "1d"
        ],
        "time_options": [
          "5m",
          "15m",
          "1h",
          "6h",
          "12h",
          "24h",
          "2d",
          "7d",
          "30d"
        ]
      },
      "templating": {
        "list": [
          {
            "allValue": ".*",
            "current": {},
            "datasource": "prometheus",
            "hide": 0,
            "includeAll": true,
            "multi": false,
            "name": "Node",
            "options": [],
            "query": "label_values(kubernetes_io_hostname)",
            "refresh": 1,
            "type": "query"
          }
        ]
      },
      "annotations": {
        "list": []
      },
      "refresh": "10s",
      "schemaVersion": 12,
      "version": 13,
      "links": [],
      "gnetId": 315
    }
{{- end }}
