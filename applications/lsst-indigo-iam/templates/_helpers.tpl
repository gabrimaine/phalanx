{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "lsst-indigo-iam.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "lsst-indigo-iam.labels" -}}
helm.sh/chart: {{ include "lsst-indigo-iam.chart" . }}
{{ include "lsst-indigo-iam.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "lsst-indigo-iam.selectorLabels" -}}
app.kubernetes.io/name: {{ include "lsst-indigo-iam.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Full resource name
*/}}
{{- define "lsst-indigo-iam.fullname" -}}
{{- printf "%s-%s" .Release.Name "lsst-indigo-iam" | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/*
Service name (matches StatefulSet's serviceName)
*/}}
{{- define "lsst-indigo-iam.servicename" -}}
{{- printf "%s-headless" (include "lsst-indigo-iam.fullname" .) -}}
{{- end }}

{{/*
Short name (used in labels)
*/}}
{{- define "lsst-indigo-iam.name" -}}
{{- default "lsst-indigo-iam" .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end }}
