{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "kanidm.name" -}}
{{- default .Chart.Name | trunc 63 }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "kanidm.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "kanidm.labels" -}}
helm.sh/chart: {{ include "kanidm.chart" . }}
{{ include "kanidm.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- if .Values.global.labels }}
{{ toYaml .Values.global.labels }}
{{- end }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "kanidm.selectorLabels" -}}
app.kubernetes.io/name: {{ include "kanidm.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
TLS secret name
*/}}
{{- define "kanidm.tlsSecretName" -}}
{{- if .Values.kanidm.tls.secretName }}
{{- toYaml .Values.kanidm.tls.secretName }}
{{- else }}
{{- printf "%s-tls" (include "kanidm.name" .) }}
{{- end }}
{{- end }}

{{/*
Data volume name
*/}}
{{- define "kanidm.dataVolumeName" -}}
{{- if .Values.statefulset.storage.volumeClaimTemplate }}
{{- toYaml .Values.statefulset.storage.volumeClaimTemplate.metadata.name }}
{{- else }}
{{- printf "data" }}
{{- end }}
{{- end }}

{{/*
Service account name
*/}}
{{- define "kanidm.serviceAccountName" -}}
{{- if eq (.Values.serviceAccount.create | toString) "true" }}
{{- toYaml .Values.serviceAccount.name | default "kanidm" }}
{{- else }}
{{- printf "default" }}
{{- end }}
{{- end }}
