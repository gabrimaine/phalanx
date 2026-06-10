{{/* Standard labels for all resources */}}
{{- define "redis.labels" -}}
app.kubernetes.io/name: {{ include "redis.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
{{- end }}

{{/* Selector labels (for StatefulSet's matchLabels) */}}
{{- define "redis.selectorLabels" -}}
app.kubernetes.io/name: {{ include "redis.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/* Full resource name (e.g., "redis-primary") */}}
{{- define "redis.fullname" -}}
{{- printf "%s-%s" .Release.Name "redis" | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/* Service name (matches StatefulSet's serviceName) */}}
{{- define "redis.servicename" -}}
{{- printf "%s-headless" (include "redis.fullname" .) -}}
{{- end }}

{{/* Short name (used in labels) */}}
{{- define "redis.name" -}}
{{- default "redis" .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end }}