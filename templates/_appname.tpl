{{- /* vim: set filetype=yaml: */ -}}

{{- /* #util.appnameLen

appnameLen defines a name suitable for use in k8s-labels, it will be used as the
default app and app.kubernetes.io/name labels, it is based on the chart and disregards
the name of the release

Parameters:
- .[0].Values.chartname: Used overrides the
- .[1]: The maximum length of the label

Functions:
- util.appname: calls appnameLen with a length of 63
Usage:
  'app.kubernetes.io/name: "{{- template "util.appname" . -}}"'
  'app.kubernetes.io/name: "{{- template "util.appnameLen" (list . 63) -}}"'
*/ -}}

{{- define "util.appnameLen" -}}
  {{- $top := index . 0 }}
  {{- $len := index . 1 }}
  {{- with $top }}
  {{- $name := default .Chart.Name .Values.chartname }}
  {{- include "util.trim" (list $name $len) -}}
  {{- end }}
{{- end -}}

{{- define "util.appname" -}}
  {{- include "util.appnameLen" (list . 63) -}}
{{- end -}}
