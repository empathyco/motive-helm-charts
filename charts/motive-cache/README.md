# motive-cache

![Version: 0.1.7](https://img.shields.io/badge/Version-0.1.7-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

A Helm chart for Kubernetes

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Similar to the nodeSelector, but slightly different: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity |
| backend.namespaces | list | `[]` | Namespace(s) to look for backend pods. By default - namespace the VarnishCluster is deployed to. |
| backend.onlyReady | bool | `false` | Include (false, by default) or exclude (true) backend pods from the VCL (.Backends template var). Alters .Backends template variable based on Kubernetes health checks (by default not ready pods are also included in VCL) instead of Varnish health probes. |
| backend.port | string | `""` | The port of the backend pods being cached by Varnish. Can be port name or port number. |
| backend.selector | string | `nil` | The selector used to identify the backend Pods. |
| backend.zoneBalancing | object | `{"thresholds":[],"type":"disabled"}` | Controls Varnish backend topology aware routing which can assign weights to backends according to their geographical location. |
| backend.zoneBalancing.thresholds | list | `[]` | Array of thresholds objects to determine condition and respective weights to be assigned to backends: threshold, local - local backend weight, remote - remote backend weight |
| backend.zoneBalancing.type | string | `"disabled"` | Varnish backend zone-balancing type. Accepted values: disabled, auto, thresholds |
| fullnameOverride | string | `""` |  |
| ingress.internal.annotations | object | `{}` |  |
| ingress.internal.className | string | `"nginx-internal"` |  |
| ingress.internal.enabled | bool | `false` |  |
| ingress.internal.hosts[0].host | string | `"chart-example.local"` |  |
| ingress.internal.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.internal.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| ingress.internal.hosts[0].paths[0].port | int | `8080` |  |
| ingress.internal.hosts[0].paths[0].portName | string | `"http"` |  |
| ingress.internal.tls | list | `[]` |  |
| logFormat | string | `"json"` | Format of the logs. Can be json and console. |
| logLevel | string | `"info"` | The minimum enabled logging level. Allowed values: debug, info, warn, error, dpanic, panic, fatal. |
| metrics.enabled | bool | See values.yaml | Enable and configure a Prometheus serviceMonitor for the chart under this key. |
| metrics.prometheusRule | object | See values.yaml | Enable and configure Prometheus Rules for the chart under this key. |
| metrics.prometheusRule.defaultAlerts | object | `{"extraLabels":{},"slackChannel":"","team":""}` | Configure default alerting rules |
| monitoring | object | `{"grafanaDashboard":{"datasourceName":"","enabled":false,"labels":{},"namespace":"","title":""},"prometheusServiceMonitor":{"enabled":false,"labels":{},"namespace":"","scrapeInterval":"1m"}}` | The operator monitoring configuration object |
| monitoring.grafanaDashboard | object | `{"datasourceName":"","enabled":false,"labels":{},"namespace":"","title":""}` | A dashboard that can be installed along with the operator and used in grafana. Installed as a ConfigMap. |
| monitoring.grafanaDashboard.datasourceName | string | `""` | Name of the Grafana datasource the dashboard should use. (required) |
| monitoring.grafanaDashboard.enabled | bool | `false` | Enable or disable the ConfigMap installation. |
| monitoring.grafanaDashboard.labels | object | `{}` | ConfigMap labels. Can be used to for discovery by grafana. |
| monitoring.grafanaDashboard.namespace | string | `""` | Namespace that the ConfigMap with the dashboard should be installed to. Default to the namespace VarnishCluster is installed to |
| monitoring.grafanaDashboard.title | string | `""` | Title of the Grafana dashboard. Default: Varnish (<cluster namespace>/<name>) |
| monitoring.prometheusServiceMonitor | object | `{"enabled":false,"labels":{},"namespace":"","scrapeInterval":"1m"}` | The Prometheus ServiceMonitor that is preconfigured to monitors the operator pods. |
| monitoring.prometheusServiceMonitor.enabled | bool | `false` | Enable or disable ServiceMontitor installation. |
| monitoring.prometheusServiceMonitor.labels | object | `{}` | ServiceMonitor labels that will be used by Prometheus instance to discover this ServiceMonitor. |
| monitoring.prometheusServiceMonitor.namespace | string | `""` | The namespace it should be installed to. Default to the namespace VarnishCluster is installed to |
| monitoring.prometheusServiceMonitor.scrapeInterval | string | `"1m"` | The interval at which Prometheus should scrape the metrics. Default: 1m |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` | Node selector to control where the Varnish pods should be scheduled |
| podAntiAffinity | string | `"hard"` |  |
| podAntiAffinityTopologyKey | string | `"kubernetes.io/hostname"` |  |
| podDisruptionBudget | object | `{"maxUnavailable":null,"minAvailable":1}` | Pod Disruption Budget configuration. Can be used to tell Kubernetes how many pods are required to be up (or allowed to be down) to not cause service disruption |
| podDisruptionBudget.maxUnavailable | string | `nil` | An eviction is allowed if at most maxUnavailable pods are unavailable after the eviction, i.e. even in absence of the evicted pod. This is a mutually exclusive setting with minAvailable |
| podDisruptionBudget.minAvailable | int | `1` | An eviction is allowed if at least minAvailable pods will still be available after the eviction, i.e. even in the absence of the evicted pod |
| replicas | int | `1` | Number of Varnish nodes |
| service | object | `{"annotations":{},"controllerMetricsNodePort":30002,"metricsNodePort":30001,"metricsPort":9131,"nodePort":30000,"port":80,"type":"ClusterIP"}` | Varnish service configuration. |
| service.annotations | object | `{}` | Additional annotations for the service. |
| service.controllerMetricsNodePort | int | `30002` | The port number used to set NodePort for Varnish Controller Metrics exporter. Service type `NodePort should be selected. |
| service.metricsNodePort | int | `30001` | The port number used to set NodePort for Varnish Metrics Exporter. Service type `NodePort should be selected. |
| service.metricsPort | int | `9131` | The port that will expose the Prometheus metrics exporter. |
| service.nodePort | int | `30000` | The port number used to set NodePort for Varnish. Service type `NodePort should be selected. |
| service.port | int | `80` | The port number used to expose Varnish pods. |
| service.type | string | `"ClusterIP"` | Type of the Service. Allowed values: ClusterIP; LoadBalancer; NodePort |
| tolerations | list | `[]` | Configuration that defines which node taints can the pods tolerate. For example to allow Varnish pods to run on nodes that are marked (tainted) as machines dedicated for in-memory cache |
| updateStrategy | object | `{"delayedRollingUpdate":{"delaySeconds":60},"rollingUpdate":{"partition":0},"type":"OnDelete"}` | Allows to control the way Varnish pods will be updated. |
| updateStrategy.delayedRollingUpdate | object | `{"delaySeconds":60}` | Configuration for DelayedRollingUpdate strategy |
| updateStrategy.delayedRollingUpdate.delaySeconds | int | `60` | Indicates the wait time between pod reloads during rolling update |
| updateStrategy.rollingUpdate | object | `{"partition":0}` | Used to communicate parameters when type is RollingUpdate |
| updateStrategy.rollingUpdate.partition | int | `0` | Partition indicates the ordinal at which the StatefulSet should be partitioned. |
| updateStrategy.type | string | `"OnDelete"` | Defines the type of the update strategy. (RollingUpdate, OnDelete, DelayedRollingUpdate) |
| varnish | object | `{"args":[],"controller":{"imagePullPolicy":"IfNotPresent","resources":{"limits":{"memory":"128Mi"},"requests":{"cpu":"10m","memory":"64Mi"}}},"imagePullPolicy":"IfNotPresent","metricsExporter":{"imagePullPolicy":"IfNotPresent","resources":{"limits":{"memory":"32Mi"},"requests":{"cpu":"10m","memory":"16Mi"}}},"resources":{"limits":{"memory":"192Mi"},"requests":{"cpu":"20m","memory":"128Mi"}}}` | An object that defines the configuration of a particular Varnish instance being deployed |
| varnish.args | list | `[]` | Additional Varnish daemon arguments |
| varnish.controller | object | `{"imagePullPolicy":"IfNotPresent","resources":{"limits":{"memory":"128Mi"},"requests":{"cpu":"10m","memory":"64Mi"}}}` | An object that defines the configuration of a particular Varnish controller being deployed |
| varnish.imagePullPolicy | string | `"IfNotPresent"` | Image pull policy for the Varnish container. |
| varnish.metricsExporter | object | `{"imagePullPolicy":"IfNotPresent","resources":{"limits":{"memory":"32Mi"},"requests":{"cpu":"10m","memory":"16Mi"}}}` | An object that defines the configuration of a particular Varnish Prometheus metrics exporter being deployed |
| varnish.resources | object | `{"limits":{"memory":"192Mi"},"requests":{"cpu":"20m","memory":"128Mi"}}` | Resource requests and limits for Varnish container. |
| vcl | object | `{"configMapName":"","entrypointFileName":""}` | An object that defines the VCL ConfigMap configuration |
| vcl.configMapName | string | `""` | Name of the ConfigMap containing the VCL configuration files |
| vcl.entrypointFileName | string | `""` | The name of the main VCL file |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.3](https://github.com/norwoodj/helm-docs/releases/v1.11.3)
