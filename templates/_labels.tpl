{{- /* vim: set filetype=yaml: */ -}}

{{- /*  Including recommended k8s labels as per 
        https://kubernetes.io/docs/concepts/overview/working-with-objects/common-labels/ */}}

{{- define "util.selectorLabels" -}}
app.kubernetes.io/name: &appname {{ include "util.appname" . | quote }}
app.kubernetes.io/instance: {{ .Release.Name | quote }}
{{- end -}}

{{- define "util.labels" -}}
{{- include "util.selectorLabels" . }}
helm.sh/chart: {{ include "util.chartref" . | quote}}
{{ with .Release.Service -}} app.kubernetes.io/managed-by: {{ . }}{{ end }}
{{ with .Chart.AppVersion -}} app.kubernetes.io/version: {{ . | replace "+" "_" }}{{ end }}
app: *appname
{{- end -}}

