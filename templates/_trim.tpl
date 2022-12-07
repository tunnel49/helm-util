{{- /* vim: set filetype=yaml: */ -}}

{{- /* 
# util.trim
trim tries to trim a valid string to a valid k8s label.
the length will be cut, it will be made into lowercase and trailing "-" are removed

Parameters:
- .[0] The input string to be trimmed
- .[1] The maximum length of the target string (before trimming trailing "-")

*/ -}}

{{- define "util.trim" -}}
  {{- $name := index . 0 }}
  {{- $length := int (index . 1) }}
  {{- $name | lower | trunc $length | trimSuffix "-" -}}
{{- end -}}


