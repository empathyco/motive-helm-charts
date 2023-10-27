{{/*
Expand the name of the chart.
*/}}
{{- define "motive-cronjob.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "motive-cronjob.fullname" -}}
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
{{- define "motive-cronjob.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "motive-cronjob.labels" -}}
helm.sh/chart: {{ include "motive-cronjob.chart" . }}
{{ include "motive-cronjob.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "motive-cronjob.selectorLabels" -}}
app.kubernetes.io/name: {{ include "motive-cronjob.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "motive-cronjob.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "motive-cronjob.fullname" .) .Values.serviceAccount.name }}
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
{{- define "motive-cronjob.affinity" -}}
{{- if or $.Values.cronjob.podAntiAffinity $.Values.cronjob.affinity -}}
affinity:
  {{- with $.Values.cronjob.affinity }}
  {{- toYaml . | nindent 2 }}
  {{- end }}
  {{- if eq $.Values.cronjob.podAntiAffinity "hard" }}
  podAntiAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      - labelSelector:
          matchLabels:
            {{- include "motive-cronjob.selectorLabels" $ | nindent 12 }}
        topologyKey: {{ .Values.cronjob.podAntiAffinityTopologyKey }}
  {{- else if eq $.Values.cronjob.podAntiAffinity "soft" }}
  podAntiAffinity:
    preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 100
        podAffinityTerm:
          labelSelector:
            matchLabels:
              {{- include "motive-cronjob.selectorLabels" $ | nindent 14 }}
          topologyKey: {{ .Values.cronjob.podAntiAffinityTopologyKey }}
  {{- end }}
{{- end }}
{{- end }}

{{- define "motive-cronjob.topologySpreadConstraints" -}}
{{- $topologySpreadConstraintsSection := $.Values.cronjob.topologySpreadConstraints -}}
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
        {{- include "motive-cronjob.selectorLabels" $ | nindent 8 }}
      {{- end -}}
  {{- end -}}
{{- end -}}
{{- end -}}
