# motive-cronjob

![Version: 1.0.1](https://img.shields.io/badge/Version-1.0.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.0.0](https://img.shields.io/badge/AppVersion-1.0.0-informational?style=flat-square)

A Helm chart for Kubernetes

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cronjob.affinity | object | `{}` | Similar to the nodeSelector, but slightly different: https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#affinity-and-anti-affinity |
| cronjob.annotations | object | `{}` | Annotations to be added to the controller Deployment or DaemonSet |
| cronjob.concurrencyPolicy | string | `"Forbid"` | Specifies how to treat concurrent executions of a Job |
| cronjob.containerSecurityContext | object | `{}` | Allows you to set the securityContext for the main container See https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/ for notes on enabling and using sysctls |
| cronjob.env | object | `{}` |  |
| cronjob.extraEnv | object | `{}` |  |
| cronjob.extraInitContainers | list | `[]` | Containers, which are run before the app containers are started. |
| cronjob.extraVolumeMounts | list | `[]` | Additional volumeMounts to the service main container. |
| cronjob.extraVolumes | list | `[]` | Additional volumes to the controller pod. |
| cronjob.failedJobsHistoryLimit | int | `1` | The number of failed finished jobs to retain |
| cronjob.image.pullPolicy | string | `"IfNotPresent"` | The Kubernetes imagePullPolicy value |
| cronjob.image.repository | string | `"hello-world"` | Docker image repository |
| cronjob.image.tag | string | `"latest"` | Overrides the image tag whose default is the chart appVersion. |
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
| cronjob.labels | object | `{}` | Labels to be added to the service Deployment or DaemonSet and other resources that do not have option to specify labels |
| cronjob.lifecycle | string | `nil` | Improve connection draining when ingress controller pod is deleted using a lifecycle hook: |
| cronjob.nodeSelector | object | `{"kubernetes.io/os":"linux"}` | Labels of the node(s) where the application pods are allowed to be executed in. Empty means 'any available node' https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/#nodeselector |
| cronjob.podAnnotations | object | `{}` | Configurable annotations applied to all pods |
| cronjob.podAntiAffinity | string | `"hard"` |  |
| cronjob.podAntiAffinityTopologyKey | string | `"kubernetes.io/hostname"` |  |
| cronjob.podLabels | object | `{}` | Configurable labels applied to all pods |
| cronjob.podSecurityContext | object | `{}` | Allows you to set the securityContext for the pod |
| cronjob.resources.limits | object | `{}` |  |
| cronjob.resources.requests.cpu | string | `"100m"` | CPU requests for the Deployment |
| cronjob.resources.requests.memory | string | `"256Mi"` | Memory requests for the Deployment |
| cronjob.schedule | string | `"0 0 * * *"` | The schedule in cron format |
| cronjob.startingDeadlineSeconds | string | `nil` | Optional deadline in seconds for starting the job |
| cronjob.successfulJobsHistoryLimit | int | `3` | The number of successful finished jobs to retain |
| cronjob.suspend | string | `"false"` | This flag tells the controller to suspend subsequent executions |
| cronjob.sysctls | object | `{}` | See https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/ for notes on enabling and using sysctls |
| cronjob.terminationGracePeriodSeconds | int | `60` | `terminationGracePeriodSeconds` to avoid killing pods before we are ready # wait up to 1 minute for the drain of connections |
| cronjob.timeZone | string | `"Etc/UTC"` | The time zone https://en.wikipedia.org/wiki/List_of_tz_database_time_zones |
| cronjob.tolerations | list | `[]` | If the application needs to run on tainted nodes, the application needs to have the corresponding tolerations, so kubernetes can schedule to the tainted nodes. If the application is required to run on specific nodes that are tainted, configure also nodeSelector. https://kubernetes.io/docs/concepts/scheduling-eviction/taint-and-toleration/ |
| cronjob.topologySpreadConstraints | object | `{"maxSkew":1,"topologyKey":"kubernetes.io/hostname","whenUnsatisfiable":"ScheduleAnyway"}` | topologySpreadConstraints allows to customize the default topologySpreadConstraints. This can be either a single dict as shown below or a slice of topologySpreadConstraints. labelSelector is taken from the constraint itself (if it exists) or is generated by the chart using the same selectors as for services. # Ref: https://kubernetes.io/docs/concepts/workloads/pods/pod-topology-spread-constraints/ |
| externalSecrets.externalSecrets | list | `[]` |  |
| externalSecrets.secretStores | list | `[]` |  |
| fullnameOverride | string | `""` |  |
| imagePullSecrets | list | `[]` | Configuration for imagePullSecrets so that you can use a private registry for your image # Ref: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/ |
| nameOverride | string | `""` |  |
| revisionHistoryLimit | int | 3 | How many old ReplicaSets to maintain for the Deployment |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.automountServiceAccountToken | bool | `true` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.iam.enabled | bool | `false` |  |
| serviceAccount.iam.policy | string | `""` |  |
| serviceAccount.iam.role.awsAccountID | string | `""` |  |
| serviceAccount.iam.role.eksClusterOIDCIssuer | string | `""` |  |
| serviceAccount.iam.role.maxSessionDuration | int | `3600` |  |
| serviceAccount.name | string | `""` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.3](https://github.com/norwoodj/helm-docs/releases/v1.11.3)
