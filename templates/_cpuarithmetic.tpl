{{- /* 
util.embedded-tpl will apply a layer of templating on a source string and then 
replace occurences of the embedded template delimiters with `{{` and `}}` respectively.

This takes an array of four elements:
- the template context
- the template opening delimiter for the embedded template
- the template closing delimiter for the embedded template
- the template body

Usage example:
{{ include "util.embedded-tpl" (list $ "{|" "|}" "template")) }}
{{ define "template" }}
{| .Labels.namespace |}
{{ end }}

*/ -}}
{{- define "util.cpuPercent" }}

{{- $cpuvalue   := first . -}}
{{- $percentage := index . 1 -}}

{{- if regexFind "^[0-9]$" $cpuvalue -}}
{{- $millicores := $cpuvalue | atoi | mul 1000 -}}
{{- else -}}
{{- $millicores := mustRegexFind "^[0-9]+(?=m$)" $cpuvalue | atoi -}}
{{- end -}}

{{- (include $template $context) | replace $oDelim `{{` | replace $cDelim `}}` -}}
{{- end }}
