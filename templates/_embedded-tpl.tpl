{{- /* 
util.embedded-tpl will apply a layer of templating on a source string and then 
replace occurences of the embedded template delimiters with `{{` and `}}` respectively.

This takes an array of four elements:
- the template context
- the template opening delimiter for the embedded template
- the template closing delimiter for the embedded template
- the template body

Usage example:
{{ include "util.embedded-tpl" (list $ "{|" "|}" "template") }}
{{ define "template" }}
{| .Labels.namespace |}
{{ end }}

*/ -}}
{{- define "util.embedded-tpl" }}

{{- $context  := first . -}}
{{- $oDelim   := index . 1 -}}
{{- $cDelim   := index . 2 -}}
{{- $template := index . 3 -}}

{{- (include $template $context) | replace $oDelim `{{` | replace $cDelim `}}` -}}
{{- end }}
