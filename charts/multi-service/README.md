# multi-service

![Version: 0.3.2](https://img.shields.io/badge/Version-0.3.2-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 0.1.1](https://img.shields.io/badge/AppVersion-0.1.1-informational?style=flat-square)

A Helm chart for Kubernetes

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` | Settings for affinity |
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
| extraenv | object | `{}` |  |
| fullnameOverride | string | `""` | Overrides the clusterName and nodeGroup when used in the naming of resources. This should only be used when using a single nodeGroup, otherwise you will have name conflicts |
| image.pullPolicy | string | `"IfNotPresent"` | The Kubernetes imagePullPolicy value |
| image.repository | string | `"hello-world"` | Docker image repository |
| image.tag | string | `"latest"` | Overrides the image tag whose default is the chart appVersion. |
| imagePullSecrets | list | `[]` | Configuration for imagePullSecrets so that you can use a private registry for your image |
| ingress.enabled | bool | `false` | Enable Kubernetes Ingress to expose pods |
| ingresses | object | `{}` |  |
| initContainers | list | `[]` | -------------- |
| keda | object | `{"apiVersion":"keda.sh/v1alpha1","behavior":{},"cooldownPeriod":300,"enabled":false,"maxReplicas":5,"minReplicas":1,"pollingInterval":30,"restoreToOriginalReplicaCount":false,"scaledObject":{"annotations":{}},"triggers":[]}` | --- |
| kind | string | `"Deployment"` | kind of deployment (Deployment or StatefulSet) |
| livenessProbe | object | `{}` | Enable livenessProbe |
| maxUnavailable | int | `1` | TBD |
| metrics | object | `{"enabled":false,"prometheusRule":{"alerting":{"rules":[]},"enabled":false,"labels":{},"recording":{"rules":[]}},"serviceMonitors":{}}` | --------- |
| metrics.enabled | bool | See values.yaml | Enable and configure a Prometheus serviceMonitor for the chart under this key. |
| metrics.prometheusRule | object | See values.yaml | Enable and configure Prometheus Rules for the chart under this key. |
| metrics.prometheusRule.alerting | object | `{"rules":[]}` | Configure additional alerting rules for the chart under this key |
| metrics.prometheusRule.recording | object | `{"rules":[]}` | Configure additional recording rules for the chart under this key |
| minReadySeconds | int | `30` | Specifies the minimum number of seconds for which a newly created Pod should be ready without any of its containers crashing, for it to be considered available |
| nameOverride | string | `""` | Overrides the clusterName when used in the naming of resources |
| nodeSelector | object | `{}` | Configurable nodeSelector so that you can target specific nodes for your deployment |
| podAnnotations | object | `{}` | Configurable annotations applied to all pods |
| podLabels | object | `{}` | Configurable labels applied to all pods |
| podSecurityContext | object | `{}` | Allows you to set the securityContext for the pod |
| readinessProbe | object | `{}` | Enable readinessProbe |
| replicaCount | int | `1` | Number of replicas |
| resources.limits | object | `{}` |  |
| resources.requests.cpu | string | `"100m"` | CPU requests for the Deployment |
| resources.requests.memory | string | `"256Mi"` | Memory requests for the Deployment |
| revisionHistoryLimit | int | `3` | How many old ReplicaSets to maintain for the Deployment |
| securityContext | object | `{}` | Allows you to set the securityContext for the container |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| services | list | `[{"annotations":{},"labels":{},"name":"example1","ports":{"name":"http","port":80,"protocol":"TCP","targetPort":1000},"type":"ClusterIP"},{"name":"example2","ports":{"name":"http","port":90,"protocol":"TCP","targetPort":9090},"type":"ClusterIP"}]` | ------- |
| startupProbe | object | `{}` | Enable startupProbe |
| strategy | object | `{"rollingUpdate":{"maxSurge":"25%","maxUnavailable":"25%"},"type":"RollingUpdate"}` | Specifies the strategy used to replace old Pods by new ones |
| terminationGracePeriodSeconds | int | `60` | TBD |
| tolerations | list | `[]` | Configurable tolerations |
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
