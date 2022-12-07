{{- /* vim: set filetype=yaml: */ -}}

{{- define "util.match-annotation-semver" -}}
{{- $label := index . 1 -}}
{{- $value := index . 2 -}}
{{- with lookup "v1" "Namespace" "" $.Release.Namespace -}}
{{- with index .metadata.annotations $label -}}
{{- if not semverCompare . $value -}}
{{- fail "Version doesn't match namespace annotation -}}
{{- end -}}
{{- else -}}
{{- fail "No such annotation on namespace" -}}
{{- end -}}
{{- end -}}
{{- end -}}
