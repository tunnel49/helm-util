{{- /*
util.merge will merge the output of two YAML templates and output the result.

This takes an array of three values:
- the top context
- the template name of the overrides (destination)
- the template name of the base (source)

Usage examples: 
{{- template "shared.service" (list $ "sample.service") -}}
{{- define "sample.service" -}}
metadata:
  labels:
    custom: label
spec:
  ports:
  - port: 8080
{{- end -}}

{{- define "shared.service" --}}
{{- template "util.merge" (append . "shared.service.tpl") -}}
{{- end -}}
*/ -}}

{{- define "util.merge" -}}
{{- $top := first . -}}
{{- $overrides := fromYaml (include (index . 1) $top) | default (dict ) -}}
{{- $base := fromYaml (include (index . 2) $top) | default (dict ) -}}
{{- toYaml (merge $overrides $base) -}}
{{- end -}}
