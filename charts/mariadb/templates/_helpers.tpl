{{/* Standard labels for all resources */}}
{{- define "mariadb.labels" -}}
app.kubernetes.io/name: {{ include "mariadb.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version | replace "+" "_" }}
{{- end }}

{{/* Selector labels (for StatefulSet's matchLabels) */}}
{{- define "mariadb.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mariadb.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/* Full resource name (e.g., "redis-primary") */}}
{{- define "mariadb.fullname" -}}
{{- printf "%s-%s" .Release.Name "mariadb" | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/* Service name (matches StatefulSet's serviceName) */}}
{{- define "mariadb.servicename" -}}
{{- printf "%s-headless" (include "mariadb.fullname" .) -}}
{{- end }}

{{/* Short name (used in labels) */}}
{{- define "mariadb.name" -}}
{{- default "mariadb" .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end }}