{{/*
Expand the name of the chart.
*/}}
{{- define "motive-service.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "motive-service.fullname" -}}
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
{{- define "motive-service.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "motive-service.labels" -}}
helm.sh/chart: {{ include "motive-service.chart" . }}
{{ include "motive-service.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Service labels
*/}}
{{- define "motive-service.serviceLabels" -}}
helm.sh/chart: {{ include "motive-service.chart" . }}
{{ include "motive-service.serviceSelectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "motive-service.selectorLabels" -}}
app.kubernetes.io/name: {{ include "motive-service.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: service
{{- end }}

{{/*
Service selector labels
*/}}
{{- define "motive-service.serviceSelectorLabels" -}}
app.kubernetes.io/name: {{ include "motive-service.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/component: service
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "motive-service.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "motive-service.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Common affinity definition
Pod affinity
  - Soft prefers different nodes
  - Hard requires different nodes and prefers different availibility zones
Node affinity
  - Soft prefers given user expressions
  - Hard requires given user expressions
*/}}
{{- define "motive-service.affinity" -}}
{{- if or $.Values.service.podAntiAffinity $.Values.service.affinity -}}
affinity:
  {{- with $.Values.service.affinity }}
  {{- toYaml . | nindent 2 }}
  {{- end }}
  {{- if eq $.Values.service.podAntiAffinity "hard" }}
  podAntiAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      - labelSelector:
          matchLabels:
            {{- include "motive-service.selectorLabels" $ | nindent 12 }}
        topologyKey: {{ .Values.service.podAntiAffinityTopologyKey }}
        {{- if (semverCompare ">=1.29.0-0" $.Capabilities.KubeVersion.Version) }}
        matchLabelKeys:
          - pod-template-hash
        {{- end }}
  {{- else if eq $.Values.service.podAntiAffinity "soft" }}
  podAntiAffinity:
    preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 100
        podAffinityTerm:
          labelSelector:
            matchLabels:
              {{- include "motive-service.selectorLabels" $ | nindent 14 }}
          topologyKey: {{ .Values.service.podAntiAffinityTopologyKey }}
          {{- if (semverCompare ">=1.29.0-0" $.Capabilities.KubeVersion.Version) }}
          matchLabelKeys:
            - pod-template-hash
          {{- end }}
  {{- end }}
{{- end }}
{{- end }}

{{- define "motive-service.topologySpreadConstraints" -}}
{{- $topologySpreadConstraintsSection := $.Values.service.topologySpreadConstraints -}}
{{- if $topologySpreadConstraintsSection -}}
{{- $constraints := kindIs "slice" $topologySpreadConstraintsSection | ternary $topologySpreadConstraintsSection (list $topologySpreadConstraintsSection) -}}
topologySpreadConstraints:
  {{- range $constraint := $constraints }}
  - maxSkew: {{ $constraint.maxSkew }}
    topologyKey: {{ $constraint.topologyKey }}
    whenUnsatisfiable: {{ $constraint.whenUnsatisfiable }}
    labelSelector:
      {{- if $constraint.labelSelector -}}
      {{- tpl (toYaml $constraint.labelSelector) $ | nindent 6 -}}
      {{- else }}
      matchLabels:
        {{- include "motive-service.selectorLabels" $ | nindent 8 }}
      {{- end }}
    {{- if (semverCompare ">=1.26.0-0" $.Capabilities.KubeVersion.Version) }}
    nodeAffinityPolicy: Honor
    nodeTaintsPolicy: Honor
    {{- end }}
    {{- if (semverCompare ">=1.27.0-0" $.Capabilities.KubeVersion.Version) }}
    matchLabelKeys:
      - pod-template-hash
    {{- end }}
  {{- end -}}
{{- end -}}
{{- end -}}

{{- define "motive-service.slackChannelInfo" -}}
{{- if $.Values.metrics.prometheusRule.defaultAlerts.slackChannelInfo }}
{{- $.Values.metrics.prometheusRule.defaultAlerts.slackChannelWarning }}
{{- else }}
{{- $.Values.metrics.prometheusRule.defaultAlerts.slackChannel }}
{{- end }}
{{- end -}}

{{- define "motive-service.slackChannelWarning" -}}
{{- if $.Values.metrics.prometheusRule.defaultAlerts.slackChannelWarning }}
{{- $.Values.metrics.prometheusRule.defaultAlerts.slackChannelWarning }}
{{- else }}
{{- $.Values.metrics.prometheusRule.defaultAlerts.slackChannel }}
{{- end }}
{{- end -}}

{{- define "motive-service.slackChannelCritical" -}}
{{- if $.Values.metrics.prometheusRule.defaultAlerts.slackChannelCritical }}
{{- $.Values.metrics.prometheusRule.defaultAlerts.slackChannelCritical }}
{{- else }}
{{- $.Values.metrics.prometheusRule.defaultAlerts.slackChannel }}
{{- end }}
{{- end -}}
