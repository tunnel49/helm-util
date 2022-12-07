{{- /* vim: set filetype=yaml: */ -}}

{{- /* #util.namespace
namespace allows the application namespace to be overridden in a standardized way;
especially for enabling a subchart to be installed in a different namespace than the parent object.

Parameters:
- .Values.namespace: Replaces the default .Release.namespace

Usage: 
  metadata:
    name: myapp
    namespace: {{ include "util.namespace" $ }}
    labels: &labels
      {{- include "utl.labels" $ | nindent 4 }}
*/ -}}

{{- define "util.namespace" -}}
{{- with .Values.namespace -}}
{{- . }}
{{- else -}}
{{- .Release.namespace }}
{{- end -}}
{{- end -}}
