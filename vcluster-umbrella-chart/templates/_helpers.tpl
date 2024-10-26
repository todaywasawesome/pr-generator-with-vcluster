{{/*
Expand the name of the chart.
*/}}
{{- define "vcluster-umbrella.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
Ensure the result is DNS-1035 compliant.
*/}}
{{- define "vcluster-umbrella.fullname" -}}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- $fullname := printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- $fullname := lower $fullname | regexFind "[a-z]([-a-z0-9]*[a-z0-9])?" }}
{{- $fullname := printf "x%s" $fullname | trunc 63 | trimSuffix "-" }}
{{- $fullname := trimPrefix "x" $fullname }}
{{- printf "%s" $fullname }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "vcluster-umbrella.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "vcluster-umbrella.labels" -}}
helm.sh/chart: {{ include "vcluster-umbrella.chart" . }}
{{ include "vcluster-umbrella.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "vcluster-umbrella.selectorLabels" -}}
app.kubernetes.io/name: {{ include "vcluster-umbrella.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "vcluster-umbrella.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "vcluster-umbrella.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
