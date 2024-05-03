# motive-service

![Version: 2.0.4](https://img.shields.io/badge/Version-2.0.4-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

A Helm chart for Kubernetes

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| externalSecrets.externalSecrets | list | `[]` |  |
| externalSecrets.secretStores | list | `[]` |  |
| fullnameOverride | string | `""` |  |
| imagePullSecrets | list | `[]` | Configuration for imagePullSecrets so that you can use a private registry for your image # Ref: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/ |
| ingress.internal.annotations | object | `{}` |  |
| ingress.internal.className | string | `"nginx-internal"` |  |
| ingress.internal.enabled | bool | `false` |  |
| ingress.internal.hosts[0].host | string | `"chart-example.local"` |  |
| ingress.internal.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.internal.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| ingress.internal.hosts[0].paths[0].port | int | `8080` |  |
| ingress.internal.hosts[0].paths[0].portName | string | `"http"` |  |
| ingress.internal.tls | list | `[]` |  |
| ingress.public.annotations | object | `{}` |  |
| ingress.public.className | string | `"nginx-public"` |  |
| ingress.public.enabled | bool | `false` |  |
| ingress.public.hosts[0].host | string | `"chart-example.local"` |  |
| ingress.public.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.public.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| ingress.public.hosts[0].paths[0].port | int | `8080` |  |
| ingress.public.hosts[0].paths[0].portName | string | `"http"` |  |
| ingress.public.tls | list | `[]` |  |
| metrics.enabled | bool | See values.yaml | Enable and configure a Prometheus serviceMonitor for the chart under this key. |
| metrics.podMonitor.annotations | object | `{}` |  |
| metrics.podMonitor.enabled | bool | `false` |  |
| metrics.podMonitor.labels | object | `{}` |  |
| metrics.podMonitor.metricRelabelings | list | `[]` | Prometheus [MetricRelabelConfigs] to apply to samples before ingestion |
| metrics.podMonitor.metricsPath | string | `"/metrics"` |  |
| metrics.podMonitor.metricsScheme | string | `"http"` |  |
| metrics.podMonitor.namespace | string | `""` |  |
| metrics.podMonitor.namespaceSelector | object | `{}` |  |
| metrics.podMonitor.podTargetLabels | list | `[]` |  |
| metrics.podMonitor.relabelings | list | `[]` | Prometheus [RelabelConfigs] to apply to samples before scraping |
| metrics.podMonitor.scrapeInterval | string | `"30s"` |  |
| metrics.podMonitor.scrapeTimeout | string | `"10s"` |  |
| metrics.prometheusRule | object | See values.yaml | Enable and configure Prometheus Rules for the chart under this key. |
| metrics.prometheusRule.defaultAlerts | object | `{"extraLabels":{},"kafka":{"deadLetter":{"enabled":false,"topic":null},"enabled":false,"lag":{"consumerGroup":null,"enabled":false,"namespace":"kafka-events","topics":[]}},"slackChannel":"","slackChannelCritical":"","slackChannelInfo":"","slackChannelWarning":"","team":""}` | Configure default alerting rules |
| metrics.prometheusRule.extraAlertingRules | list | `[]` | Configure additional alerting rules for the chart under this key |
| metrics.prometheusRule.extraRecordingRules | list | `[]` | Configure additional recording rules for the chart under this key |
| metrics.serviceMonitor.annotations | object | `{}` |  |
| metrics.serviceMonitor.enabled | bool | `false` |  |
| metrics.serviceMonitor.labels | object | `{}` |  |
| metrics.serviceMonitor.metricRelabelings | list | `[]` | Prometheus [MetricRelabelConfigs] to apply to samples before ingestion |
| metrics.serviceMonitor.metricsPath | string | `"/metrics"` |  |
| metrics.serviceMonitor.metricsScheme | string | `"http"` |  |
| metrics.serviceMonitor.namespace | string | `""` |  |
| metrics.serviceMonitor.namespaceSelector | object | `{}` |  |
| metrics.serviceMonitor.relabelings | list | `[]` | Prometheus [RelabelConfigs] to apply to samples before scraping |
| metrics.serviceMonitor.scrapeInterval | string | `"30s"` |  |
| metrics.serviceMonitor.scrapeTimeout | string | `"10s"` |  |
| metrics.serviceMonitor.targetLabels | list | `[]` |  |
| nameOverride | string | `""` |  |
| revisionHistoryLimit | int | 3 | How many old ReplicaSets to maintain for the Deployment |
| rollouts.canary.abortScaleDownDelaySeconds | int | `30` | TBD |
| rollouts.canary.analysis | object | `{}` | TBD |
| rollouts.canary.antiAffinity | object | `{}` | TBD |
| rollouts.canary.canaryMetadata | object | `{"annotations":{"role":"canary"},"labels":{"role":"canary"}}` | TBD |
| rollouts.canary.canaryMetadata.annotations | object | `{"role":"canary"}` | TBD |
| rollouts.canary.canaryMetadata.labels | object | `{"role":"canary"}` | TBD |
| rollouts.canary.dynamicStableScale | bool | `false` | TBD |
| rollouts.canary.enabled | bool | `false` | Specify rollout canary enablement |
| rollouts.canary.maxSurge | string | `"20%"` | TBD |
| rollouts.canary.maxUnavailable | int | `1` | TBD |
| rollouts.canary.minPodsPerReplicaSet | int | `1` | TBD |
| rollouts.canary.scaleDownDelayRevisionLimit | int | `1` | TBD |
| rollouts.canary.scaleDownDelaySeconds | int | `30` | Enable scaleDownDelaySeconds. Ignored if dynamicStableScale=true |
| rollouts.canary.stableMetadata | object | `{"annotations":{"role":"stable"},"labels":{"role":"stable"}}` | TBD |
| rollouts.canary.stableMetadata.annotations | object | `{"role":"stable"}` | TBD |
| rollouts.canary.stableMetadata.labels | object | `{"role":"stable"}` | TBD |
| rollouts.canary.steps | list | `[]` | Specify canary steps |
| rollouts.canary.trafficRouting | object | `{"nginx":{"additionalIngressAnnotations":{},"annotationPrefix":null,"enabled":true},"smi":{"enabled":false,"rootService":"","trafficSplitName":""}}` | TBD |
| rollouts.canary.trafficRouting.nginx | object | `{"additionalIngressAnnotations":{},"annotationPrefix":null,"enabled":true}` | TBD |
| rollouts.canary.trafficRouting.nginx.additionalIngressAnnotations | object | `{}` | Specify additional Ingress Annotation for traffic routing |
| rollouts.canary.trafficRouting.nginx.annotationPrefix | string | `nil` | TBD |
| rollouts.canary.trafficRouting.nginx.enabled | bool | true | TBD |
| rollouts.canary.trafficRouting.smi | object | `{"enabled":false,"rootService":"","trafficSplitName":""}` | TBD |
| rollouts.canary.trafficRouting.smi.enabled | bool | `false` | TBD |
| rollouts.canary.trafficRouting.smi.rootService | string | `""` | TBD |
| rollouts.canary.trafficRouting.smi.trafficSplitName | string | `""` | TBD |
| rollouts.enabled | bool | false | Specify rollout enablement |
| rollouts.minReadySeconds | int | `30` | Minimum number of seconds for which a newly created pod should be ready without any of its container crashing, for it to be considered available. Defaults to 0 (pod will be considered available as soon as it is ready) |
| rollouts.revisionHistoryLimit | int | 3 | The number of old ReplicaSets to retain. |
| rollouts.rollbackWindow | int | `3` | The rollback window provides a way to fast track deployments to previously deployed versions. |
| rollouts.scaleDownDeployment | bool | `false` | ScaleDown deployment after rollout migration https://argoproj.github.io/argo-rollouts/migrating/#reference-deployment-from-rollout |
| service.affinity | object | `{}` | Similar to the nodeSelector, but slightly different: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity |
| service.annotations | object | `{}` | Annotations to be added to the controller Deployment or DaemonSet |
| service.autoscaling.annotations | object | `{}` |  |
| service.autoscaling.behavior | object | `{}` |  |
| service.autoscaling.enabled | bool | `false` |  |
| service.autoscaling.maxReplicas | int | `10` |  |
| service.autoscaling.minReplicas | int | `1` |  |
| service.autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| service.autoscaling.targetMemoryUtilizationPercentage | int | `80` |  |
| service.autoscalingTemplate | list | `[]` |  |
| service.containerSecurityContext | object | `{}` | Allows you to set the securityContext for the main container See https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/ for notes on enabling and using sysctls |
| service.env | list | `[]` |  |
| service.envFrom | list | `[]` |  |
| service.extraEnv | list | `[]` |  |
| service.extraInitContainers | list | `[]` | Containers, which are run before the app containers are started. |
| service.extraVolumeMounts | list | `[]` | Additional volumeMounts to the service main container. |
| service.extraVolumes | list | `[]` | Additional volumes to the controller pod. |
| service.image.pullPolicy | string | `"IfNotPresent"` | The Kubernetes imagePullPolicy value |
| service.image.repository | string | `"hello-world"` | Docker image repository |
| service.image.tag | string | `"latest"` | Overrides the image tag whose default is the chart appVersion. |
| service.keda.apiVersion | string | `"keda.sh/v1alpha1"` |  |
| service.keda.behavior | object | `{}` |  |
| service.keda.cooldownPeriod | int | `300` |  |
| service.keda.enabled | bool | `false` |  |
| service.keda.fallback.failureThreshold | int | `3` |  |
| service.keda.maxReplicas | int | `5` |  |
| service.keda.minReplicas | int | `1` |  |
| service.keda.pollingInterval | int | `30` |  |
| service.keda.restoreToOriginalReplicaCount | bool | `false` |  |
| service.keda.scaledObject.annotations | object | `{}` |  |
| service.keda.triggers | list | `[]` |  |
| service.kind | string | `"Deployment"` | kind of deployment (Deployment or StatefulSet) |
| service.labels | object | `{}` | Labels to be added to the service Deployment or DaemonSet and other resources that do not have option to specify labels |
| service.lifecycle | string | `nil` | Improve connection draining when ingress controller pod is deleted using a lifecycle hook: |
| service.livenessProbe | object | `{}` | Enable livenessProbe |
| service.minReadySeconds | int | `30` | Specifies the minimum number of seconds for which a newly created Pod should be ready without any of its containers crashing, for it to be considered available |
| service.nodeSelector | object | `{"kubernetes.io/os":"linux"}` | Labels of the node(s) where the application pods are allowed to be executed in. Empty means 'any available node' https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector |
| service.pdb.annotations | object | `{}` | Annotations to be added to [Pod Disruption Budget] |
| service.pdb.labels | object | `{}` | Labels to be added to [Pod Disruption Budget] |
| service.pdb.maxUnavailable | string | `nil` | Maximum number / percentage of pods that may be made unavailable. If set, 'minAvailable' is ignored. |
| service.pdb.minAvailable | int | `1` | Minimum number / percentage of pods that should remain scheduled |
| service.podAnnotations | object | `{}` | Configurable annotations applied to all pods |
| service.podAntiAffinity | string | `"hard"` |  |
| service.podAntiAffinityTopologyKey | string | `"kubernetes.io/hostname"` |  |
| service.podLabels | object | `{}` | Configurable labels applied to all pods |
| service.podSecurityContext | object | `{}` | Allows you to set the securityContext for the pod |
| service.ports.metricsPort | int | `8081` |  |
| service.ports.metricsProtocol | string | `"TCP"` |  |
| service.ports.servicePort | int | `8080` |  |
| service.ports.serviceProtocol | string | `"TCP"` |  |
| service.readinessProbe | object | `{}` | Enable readinessProbe |
| service.replicaCount | int | `1` | Number of replicas |
| service.resources.limits | object | `{}` |  |
| service.resources.requests.cpu | string | `"100m"` | CPU requests for the Deployment |
| service.resources.requests.memory | string | `"256Mi"` | Memory requests for the Deployment |
| service.startupProbe | object | `{}` | Enable startupProbe |
| service.sysctls | object | `{}` | See https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/ for notes on enabling and using sysctls |
| service.terminationGracePeriodSeconds | int | `60` | `terminationGracePeriodSeconds` to avoid killing pods before we are ready # wait up to 1 minute for the drain of connections |
| service.tolerations | list | `[]` | If the application needs to run on tainted nodes, the application needs to have the corresponding tolerations, so kubernetes can schedule to the tainted nodes. If the application is required to run on specific nodes that are tainted, configure also nodeSelector. https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/ |
| service.topologySpreadConstraints | object | `{"maxSkew":1,"topologyKey":"kubernetes.io/hostname","whenUnsatisfiable":"ScheduleAnyway"}` | topologySpreadConstraints allows to customize the default topologySpreadConstraints. This can be either a single dict as shown below or a slice of topologySpreadConstraints. labelSelector is taken from the constraint itself (if it exists) or is generated by the chart using the same selectors as for services. # Ref: https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/ |
| service.type | string | `"ClusterIP"` |  |
| service.updateStrategy | object | `{"rollingUpdate":{"maxSurge":"25%","maxUnavailable":"25%"},"type":"RollingUpdate"}` | Specifies the strategy used to replace old Pods by new ones |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.automountServiceAccountToken | bool | `true` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.iam.enabled | bool | `false` |  |
| serviceAccount.iam.policy | string | `""` |  |
| serviceAccount.iam.role.awsAccountID | string | `""` |  |
| serviceAccount.iam.role.eksClusterOIDCIssuer | string | `""` |  |
| serviceAccount.iam.role.maxSessionDuration | int | `3600` |  |
| serviceAccount.name | string | `""` |  |
| slos.latency | list | `[]` | Latency SLOs |
| slos.ratio | list | `[]` | Ration SLOs |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.3](https://github.com/norwoodj/helm-docs/releases/v1.11.3)
