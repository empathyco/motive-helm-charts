# multi-service

![Version: 0.5.2](https://img.shields.io/badge/Version-0.5.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.1](https://img.shields.io/badge/AppVersion-0.1.1-informational?style=flat-square)

A Helm chart for Kubernetes

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Similar to the nodeSelector, but slightly different: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity |
| autoscaling | object | `{"enabled":false}` | ---------- |
| cronjob | object | `{"concurrencyPolicy":"Forbid","failedJobsHistoryLimit":1,"job":{"activeDeadlineSeconds":3600,"args":[],"backoffLimit":3,"command":[],"completionMode":"NonIndexed","completions":1,"parallelism":1,"restartPolicy":"OnFailure","suspend":"false","ttlSecondsAfterFinished":86400},"schedule":"0 0 * * *","startingDeadlineSeconds":null,"successfulJobsHistoryLimit":3,"suspend":"false"}` | -------------- |
| cronjob.concurrencyPolicy | string | `"Forbid"` | Specifies how to treat concurrent executions of a Job |
| cronjob.failedJobsHistoryLimit | int | `1` | The number of failed finished jobs to retain |
| cronjob.job.activeDeadlineSeconds | int | `3600` | Specifies the duration in seconds relative to the startTime that the job may be continuously active before the system tries to terminate it |
| cronjob.job.args | list | `[]` | Arguments to the entrypoint |
| cronjob.job.backoffLimit | int | `3` | Specifies the number of retries before marking this job failed |
| cronjob.job.command | list | `[]` | Entrypoint array |
| cronjob.job.completionMode | string | `"NonIndexed"` | CompletionMode specifies how Pod completions are tracked |
| cronjob.job.completions | int | `1` | Specifies the desired number of successfully finished pods the job should be run with |
| cronjob.job.parallelism | int | `1` | Specifies the maximum desired number of pods the job should run at any given time |
| cronjob.job.restartPolicy | string | `"OnFailure"` | Restart policy for all containers within the pod |
| cronjob.job.suspend | string | `"false"` | Suspend specifies whether the Job controller should create Pods or not |
| cronjob.job.ttlSecondsAfterFinished | int | `86400` | ttlSecondsAfterFinished limits the lifetime of a Job that has finished execution (either Complete or Failed) |
| cronjob.schedule | string | `"0 0 * * *"` | The schedule in cron format |
| cronjob.startingDeadlineSeconds | string | `nil` | Optional deadline in seconds for starting the job |
| cronjob.successfulJobsHistoryLimit | int | `3` | The number of successful finished jobs to retain |
| cronjob.suspend | string | `"false"` | This flag tells the controller to suspend subsequent executions |
| env | object | `{}` |  |
| externalSecrets.data | list | `[]` | TBD |
| externalSecrets.enabled | bool | false | Specify external secrets enablement |
| externalSecrets.refreshInterval | string | `"1h"` | TBD |
| externalSecrets.secretStore.create | bool | `false` | TBD |
| externalSecrets.secretStore.kind | string | `""` | TBD |
| externalSecrets.secretStore.name | string | `""` | TBD |
| externalSecrets.secretStore.provider | object | `{}` | TBD |
| extraEnv | object | `{}` |  |
| extraenv | object | `{}` |  |
| fullnameOverride | string | `""` | Overrides the clusterName and nodeGroup when used in the naming of resources. This should only be used when using a single nodeGroup, otherwise you will have name conflicts |
| image.pullPolicy | string | `"IfNotPresent"` | The Kubernetes imagePullPolicy value |
| image.repository | string | `"hello-world"` | Docker image repository |
| image.tag | string | `"latest"` | Overrides the image tag whose default is the chart appVersion. |
| imagePullSecrets | list | `[]` | Configuration for imagePullSecrets so that you can use a private registry for your image |
| ingress.enabled | bool | `false` | Enable Kubernetes Ingress to expose pods |
| ingresses | object | `{}` |  |
| initContainers | list | `[]` | -------------- |
| keda | object | `{"apiVersion":"keda.sh/v1alpha1","behavior":{},"cooldownPeriod":300,"enabled":false,"fallback":{"failureThreshold":3},"maxReplicas":5,"minReplicas":1,"pollingInterval":30,"restoreToOriginalReplicaCount":false,"scaledObject":{"annotations":{}},"triggers":[]}` | --- |
| kind | string | `"Deployment"` | kind of deployment (Deployment or StatefulSet) |
| livenessProbe | object | `{}` | Enable livenessProbe |
| metrics | object | `{"enabled":false,"prometheusRule":{"alerting":{"rules":[]},"enabled":false,"labels":{},"recording":{"rules":[]}},"serviceMonitors":{}}` | --------- |
| metrics.enabled | bool | See values.yaml | Enable and configure a Prometheus serviceMonitor for the chart under this key. |
| metrics.prometheusRule | object | See values.yaml | Enable and configure Prometheus Rules for the chart under this key. |
| metrics.prometheusRule.alerting | object | `{"rules":[]}` | Configure additional alerting rules for the chart under this key |
| metrics.prometheusRule.recording | object | `{"rules":[]}` | Configure additional recording rules for the chart under this key |
| minReadySeconds | int | `30` | Specifies the minimum number of seconds for which a newly created Pod should be ready without any of its containers crashing, for it to be considered available |
| nameOverride | string | `""` | Overrides the clusterName when used in the naming of resources |
| nodeSelector | object | `{}` | Labels of the node(s) where the application pods are allowed to be executed in. Empty means 'any available node' https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector |
| pdb.annotations | object | `{}` | Annotations to be added to [Pod Disruption Budget] |
| pdb.enabled | bool | `false` | Configure [Pod Disruption Budget] |
| pdb.labels | object | `{}` | Labels to be added to [Pod Disruption Budget] |
| pdb.maxUnavailable | string | `nil` | Maximum number / percentage of pods that may be made unavailable |
| pdb.minAvailable | string | `nil` | Minimum number / percentage of pods that should remain scheduled |
| podAnnotations | object | `{}` | Configurable annotations applied to all pods |
| podLabels | object | `{}` | Configurable labels applied to all pods |
| podSecurityContext | object | `{}` | Allows you to set the securityContext for the pod |
| readinessProbe | object | `{}` | Enable readinessProbe |
| replicaCount | int | `1` | Number of replicas |
| resources.limits | object | `{}` |  |
| resources.requests.cpu | string | `"100m"` | CPU requests for the Deployment |
| resources.requests.memory | string | `"256Mi"` | Memory requests for the Deployment |
| revisionHistoryLimit | int | `3` | How many old ReplicaSets to maintain for the Deployment |
| rollouts.blueGreen.enabled | bool | `false` | Specify rollout blue-green enablement |
| rollouts.canary.abortScaleDownDelaySeconds | int | `30` | TBD |
| rollouts.canary.analysis | object | `{}` | TBD |
| rollouts.canary.antiAffinity | object | `{}` | TBD |
| rollouts.canary.canaryMetadata.annotations | object | `{"role":"canary"}` | TBD |
| rollouts.canary.canaryMetadata.labels | object | `{"role":"canary"}` | TBD |
| rollouts.canary.dynamicStableScale | bool | `false` | TBD |
| rollouts.canary.enabled | bool | `false` | Specify rollout canary enablement |
| rollouts.canary.maxSurge | string | `"20%"` | TBD |
| rollouts.canary.maxUnavailable | int | `1` | TBD |
| rollouts.canary.minPodsPerReplicaSet | int | `1` | TBD |
| rollouts.canary.scaleDownDelayRevisionLimit | int | `1` | TBD |
| rollouts.canary.scaleDownDelaySeconds | int | `30` | Enable scaleDownDelaySeconds. Ignored if dynamicStableScale=true |
| rollouts.canary.stableMetadata.annotations | object | `{"role":"stable"}` | TBD |
| rollouts.canary.stableMetadata.labels | object | `{"role":"stable"}` | TBD |
| rollouts.canary.steps | list | `[]` | Specify canary steps |
| rollouts.canary.trafficRouting.nginx.additionalIngressAnnotations | object | `{}` | Specify additional Ingress Annotation for traffic routing |
| rollouts.canary.trafficRouting.nginx.annotationPrefix | string | `nil` | TBD |
| rollouts.canary.trafficRouting.nginx.enabled | bool | true | TBD |
| rollouts.canary.trafficRouting.smi.enabled | bool | `false` | TBD |
| rollouts.canary.trafficRouting.smi.rootService | string | `""` | TBD |
| rollouts.canary.trafficRouting.smi.trafficSplitName | string | `""` | TBD |
| rollouts.enabled | bool | false | Specify rollout enablement |
| rollouts.minReadySeconds | int | `30` | Minimum number of seconds for which a newly created pod should be ready without any of its container crashing, for it to be considered available. Defaults to 0 (pod will be considered available as soon as it is ready) |
| rollouts.revisionHistoryLimit | int | 3 | The number of old ReplicaSets to retain. |
| rollouts.rollbackWindow | int | `3` | The rollback window provides a way to fast track deployments to previously deployed versions. |
| rollouts.scaleDownDeployment | bool | `false` | ScaleDown deployment after rollout migration https://argoproj.github.io/argo-rollouts/migrating/#reference-deployment-from-rollout |
| securityContext | object | `{}` | Allows you to set the securityContext for the container |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| services | list | `[{"annotations":{},"labels":{},"name":"example1","ports":{"name":"http","port":80,"protocol":"TCP","targetPort":1000},"type":"ClusterIP"},{"name":"example2","ports":{"name":"http","port":90,"protocol":"TCP","targetPort":9090},"type":"ClusterIP"}]` | ------- |
| slo[0].metric | string | `"http_request_duration_seconds_bucket{status=\"200\", le=\"0.25\"}"` |  |
| slo[0].metricTotal | string | `"http_request_duration_seconds_count{status=\"200\"}"` |  |
| slo[0].type | string | `"latency"` |  |
| slo[1].metric | string | `"http_requests{status=~\"5..\"}"` |  |
| slo[1].metricTotal | string | `"http_requests"` |  |
| slo[1].type | string | `"ratio"` |  |
| startupProbe | object | `{}` | Enable startupProbe |
| strategy | object | `{"rollingUpdate":{"maxSurge":"25%","maxUnavailable":"25%"},"type":"RollingUpdate"}` | Specifies the strategy used to replace old Pods by new ones |
| terminationGracePeriodSeconds | int | `60` | TBD |
| tolerations | list | `[]` | If the application needs to run on tainted nodes, the application needs to have the corresponding tolerations, so kubernetes can schedule to the tainted nodes. If the application is required to run on specific nodes that are tainted, configure also nodeSelector. https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/ |
| topologySpreadConstraints | list | `[]` | Instruct the kube-scheduler how to place each incoming Pod in relation to the existing Pods across your cluster |
| volumeClaimTemplates.accessModes | string | `"ReadWriteOnce"` | persistent volume access Modes |
| volumeClaimTemplates.enabled | bool | `false` |  |
| volumeClaimTemplates.storage | string | `"10Gi"` | persistent volume size |
| volumeClaimTemplates.storageClassName | string | `"gp3"` | volume storage Class |
| volumeClaimTemplates.volumeMode | string | `"Filesystem"` |  |
| volumeMounts | list | `[]` |  |
| volumes | list | `[]` | ------ |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.0](https://github.com/norwoodj/helm-docs/releases/v1.11.0)
