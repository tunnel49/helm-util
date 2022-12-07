{{- /* vim: set filetype=yaml: */ -}}

{{- /* #util.fullnameLen
fullnameLen defines a unique name for an application
it is suitable to use as the `metadata.name` of a manifest when there is only a single manifest of that type in the chart.

names should only contain a-z, 0-9 plus dot (.) and dash (-), and should
not exceed 63 characters. Some resources should use shorter names to leave space for child objects.

- deployment: 46 chars
- cronjob: 46 chars
- job: 57 chars
- daemonset: 57 chars
- statefulset: 60 chars

Parameters:
- .[0].Values.fullname: Replaces the computed name with this given name
- .[0].Values.chartname: Replaces the actual chart name with this value for calculations
- .[1]: The length to trim the full name to

Functions:
- fullname: takes only the context and defaults to 46 characters to comply with all objecttypes
- fullnameLong: takes only the context and defaults to the (maximum) of 63 characters.

Usage: 
  'name: "{{- template "util.fullnameLen" (list . 63) -}}"'
  'name: "{{- template "util.fullname" . -}}"'
  'name: "{{- template "util.fullnameLong" . -}}"'
*/ -}}

{{- define "util.fullnameLen" -}}
  {{- $top := index . 0 -}}
  {{- $len := index . 1 -}}
  {{- with $top }}
  {{-   if .Values.fullname }}
  {{-     include "util.trim" (list .Values.fullname $len) }} 
  {{-   else }}
  {{-   $name := default .Chart.Name .Values.chartname }}
  {{-     if contains $name .Release.Name }}
  {{-       include "util.trim" (list .Release.Name $len) -}}
  {{-     else }}
  {{-       include "util.trim" (list (printf "%s-%s" .Release.Name $name) $len) -}}
  {{-     end }}
  {{-   end }}
  {{- end }}
{{- end -}}
{{- define "util.fullname" -}}
  {{- include "util.fullnameLen" . 46 -}}
{{- end -}}
{{- define "util.fullnameLong" -}}
  {{- include "util.fullnameLen" . 63 -}}
{{- end -}}

{{- /* #util.qualifyLen
qualifyLen defines a unique name for a manifest using the fullname and an additional qualifier.
it is suitable to use as the `metadata.name` of manifests where util.fullnameLen is insufficient.
Any triming is done from the fullname, leaving the qualifier intact.

See documentation for util.fullnameLen for additional information.

Parameters:
- .[0].Values.fullname: Used in util.fullnameLen
- .[0].Values.chartname: Used in util.fullnameLen
- .[1]: A qualifier appended to the fullname
- .[2]: The total maximum length to trim to, any triming is done from the end of the fullname.

Functions:
- util.qualify: calls qualifyLen with a length of 46
- util.qualifyLong: calls qualifyLen with a length of 63
Usage:
  'name: "{{- template "util.qualifyLen" (list . "cfg" 63) -}}"'
  'name: "{{- template "util.qualifyLong" (list . "cfg") -}}"'
  'name: "{{- template "util.qualify" (list . "mysql") -}}"'
*/ -}}

{{- define "util.qualifyLen" -}}
  {{- $top := index . 0 -}}
  {{- $name := index . 1 | lower | trimSuffix "-" -}}
  {{- $maxlen := index . 2 -}}
  {{- $len := add1 (len $name) -}}
  {{- $prefixlen := sub $maxlen $len -}}
  {{- $prefix := include "util.fullnameLen" (list $top $prefixlen) -}}
  {{- printf "%s-%s" $prefix $name -}}
{{- end -}}
{{- define "util.qualifyLong" -}}
  {{- include "util.qualifyLen" (append . 63) -}}
{{- end -}}
{{- define "util.qualify" -}}
  {{- include "util.qualifyLen" (append . 46) -}}
{{- end }}

{{- /* #util.qualifyLen 
qualifyLen defines a unique name for a manifest using the fullname and an additional qualifier.
it is suitable to use as the `metadata.name` of manifests where util.fullnameLen is insufficient.
Any triming is done from the fullname, leaving the qualifier intact.

See documentation for util.fullnameLen for additional information.

Parameters:
- .[0].Values.fullname: Used in util.fullnameLen
- .[0].Values.chartname: Used in util.fullnameLen
- .[1]: A qualifier appended to the fullname
- .[2]: The total maximum length to trim to, any triming is done from the end of the fullname.

Functions:
- util.qualify: calls qualifyLen with a length of 46
- util.qualifyLong: calls qualifyLen with a length of 63
Usage:
  'name: "{{- template "util.qualifyLen" (list . "cfg" 63) -}}"'
  'name: "{{- template "util.qualifyLong" (list . "cfg") -}}"'
  'name: "{{- template "util.qualify" (list . "mysql") -}}"'
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
