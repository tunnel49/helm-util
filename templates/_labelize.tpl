{{- /*
util.labelize takes a dict or map and generates labels.

Values will be quoted. Keys will not.

Example output:

  first: "Matt"
  last: "Butcher"

*/ -}}
{{- define "util.labelize" -}}
{{- range $k, $v := . }}
{{ $k }}: {{ $v | quote }}
{{- end -}}
{{- end -}}

