{{/*
Expand the name of the chart.
*/}}
{{- define "empathy-service.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "empathy-service.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "empathy-service.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "empathy-service.selectorLabels" -}}
app.kubernetes.io/name: {{ include "empathy-service.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "empathy-service.labels" -}}
helm.sh/chart: {{ include "empathy-service.chart" . }}
{{ include "empathy-service.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- with .Values.commonLabels }}
{{ toYaml . }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "empathy-service.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "empathy-service.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the proper image name
*/}}
{{- define "empathy-service.image" -}}
{{- $repository := .Values.image.repository -}}
{{- $tag := .Values.image.tag | default .Chart.AppVersion | toString -}}
{{- if .Values.image.registry }}
{{- printf "%s/%s" .Values.image.registry $repository -}}
{{- else }}
{{- printf "%s" $repository -}}
{{- end }}
{{- if .Values.image.digest }}
{{- printf "@%s" .Values.image.digest -}}
{{- else }}
{{- printf ":%s" $tag -}}
{{- end }}
{{- end }}

{{/*
Ports for the main container and Service: `http` plus optional `metrics` when
`service.metricsPort` is set, positive, and distinct from `service.port`.
Each item: name, containerPort, servicePort, protocol.
*/}}
{{- define "empathy-service.ports" -}}
{{- $httpPort := int .Values.service.port -}}
{{- $metricsPort := int (.Values.service.metricsPort | default 0) -}}
{{- $metricsEnabled := and (gt $metricsPort 0) (ne $metricsPort $httpPort) -}}
{{- $ports := list (dict "name" "http" "containerPort" $httpPort "servicePort" $httpPort "protocol" "TCP") -}}
{{- if $metricsEnabled -}}
{{- $ports = append $ports (dict "name" "metrics" "containerPort" $metricsPort "servicePort" $metricsPort "protocol" "TCP") -}}
{{- end -}}
{{- toYaml $ports -}}
{{- end }}

{{/*
Kubernetes port name used by ServiceMonitor/PodMonitor when scraping metrics.
Returns `metrics` only when a distinct metrics port is rendered; otherwise `http`
(same port as app, or metrics disabled).
*/}}
{{- define "empathy-service.metricsPortName" -}}
{{- $httpPort := int .Values.service.port -}}
{{- $metricsPort := int (.Values.service.metricsPort | default 0) -}}
{{- if and (gt $metricsPort 0) (ne $metricsPort $httpPort) -}}metrics{{- else -}}http{{- end -}}
{{- end }}

{{/*
Target Kubernetes Secret name for an externalSecrets.items[] entry (must match ExternalSecret spec.target.name).
*/}}
{{- define "empathy-service.externalSecretTargetName" -}}
{{- $root := .root -}}
{{- $item := .item -}}
{{- if and $item.target $item.target.name -}}
{{- $item.target.name -}}
{{- else -}}
{{- printf "%s-%s" (include "empathy-service.fullname" $root) ($item.name | toString) -}}
{{- end -}}
{{- end }}

{{/*
YAML for Deployment envFrom: one `- secretRef:` per externalSecrets.items[] with mountAsEnvFrom.
Empty when externalSecrets are disabled or no item opts in. Root context is the chart root.
*/}}
{{- define "empathy-service.externalSecretEnvFromYaml" -}}
{{- $ext := .Values.externalSecrets | default dict }}
{{- if ($ext.enabled | default true) }}
{{- range ($ext.items | default list) }}
{{- if .mountAsEnvFrom }}
- secretRef:
    name: {{ include "empathy-service.externalSecretTargetName" (dict "root" $ "item" .) }}
{{- end }}
{{- end }}
{{- end }}
{{- end }}
