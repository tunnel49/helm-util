{{- /* vim: set filetype=yaml: */ -}}

{{- /*
serviceaccount specifies the name of the service account to be used for running the application
the default varies depending on if the account is created by this chart or not.

Parameters:
- .Values.ServiceAccount.Create: Specifies if a ServiceAccount is created by this chart
- .Values.ServiceAccount.Name: Specifies the name of the ServiceAccount to use

The applied order is: "global prefix + prefix + name + suffix + global suffix"

Usage: 'serviceAccount: "{{- template "util.serviceAccount" . -}}"'
*/ -}}
{{- define "util.serviceAccount" -}}
  {{- if .Values.serviceAccount.create -}}
  {{- default (include "fullname" .) .Values.ServiceAccount.Name -}}
  {{- else -}}
  {{- default "default" .Values.ServiceAccount.Name -}}
  {{- end -}}
{{- end -}}
