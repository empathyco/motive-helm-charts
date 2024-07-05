{{/*
Expand the name of the chart.
*/}}
{{- define "motive-cache.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "motive-cache.fullname" -}}
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
{{- define "motive-cache.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "motive-cache.labels" -}}
helm.sh/chart: {{ include "motive-cache.chart" . }}
{{ include "motive-cache.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "motive-cache.selectorLabels" -}}
app.kubernetes.io/name: {{ include "motive-cache.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
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
{{- define "motive-cache.affinity" -}}
{{- if or $.Values.podAntiAffinity $.Values.affinity -}}
affinity:
  {{- with $.Values.affinity }}
  {{- toYaml . | nindent 2 }}
  {{- end }}
  {{- if eq $.Values.podAntiAffinity "hard" }}
  podAntiAffinity:
    requiredDuringSchedulingIgnoredDuringExecution:
      - labelSelector:
          matchLabels:
            {{- include "motive-cache.selectorLabels" $ | nindent 12 }}
        topologyKey: {{ $.Values.podAntiAffinityTopologyKey }}
{{/*        {{- if (semverCompare ">=1.29.0-0" $.Capabilities.KubeVersion.Version) }}*/}}
{{/*        matchLabelKeys:*/}}
{{/*          - pod-template-hash*/}}
{{/*        {{- end -}}*/}}
  {{- else if eq $.Values.podAntiAffinity "soft" }}
  podAntiAffinity:
    preferredDuringSchedulingIgnoredDuringExecution:
      - weight: 100
        podAffinityTerm:
          labelSelector:
            matchLabels:
              {{- include "motive-cache.selectorLabels" $ | nindent 14 }}
          topologyKey: {{ $.Values.podAntiAffinityTopologyKey }}
{{/*          {{- if (semverCompare ">=1.29.0-0" $.Capabilities.KubeVersion.Version) }}*/}}
{{/*          matchLabelKeys:*/}}
{{/*            - pod-template-hash*/}}
{{/*          {{- end -}}*/}}
  {{- end -}}
{{- end }}
{{- end }}
