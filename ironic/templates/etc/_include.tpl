{{- define "template" -}}
{{- $template := index . 0 -}}
{{- $context := index . 1 -}}
{{- $v := $context.Template.Name | split "/" -}}
{{- $last := sub (len $v) 1 | printf "_%d" | index $v -}}
{{- $wtf := printf "%s%s" ($context.Template.Name | trimSuffix $last) $template -}}
{{ include $wtf $context }}
{{- end -}}

{{define "oslo_messaging_rabbit"}}
[oslo_messaging_rabbit]
rabbit_userid = {{ .Values.rabbitmq_user | default .Values.rabbitmq.default_user }}
rabbit_password = {{ .Values.rabbitmq_pass | default .Values.rabbitmq.default_pass }}
rabbit_hosts =  {{include "rabbitmq_host" .}}
rabbit_ha_queues = {{ .Values.rabbitmq_ha_queues | .Values.rabbitmq_ha_queues | default "true" }}
{{end}}

{{define "rabbitmq_host"}}rabbitmq.{{.Release.Namespace}}.svc.kubernetes.{{.Values.region}}.{{.Values.tld}}{{end}}
{{define "memcached_host"}}memcached.{{.Release.Namespace}}.svc.kubernetes.{{.Values.region}}.{{.Values.tld}}{{end}}

{{define "keystone_api_endpoint_host_admin"}}keystone.{{.Release.Namespace}}.svc.kubernetes.{{.Values.region}}.{{.Values.tld}}{{end}}
{{define "keystone_api_endpoint_host_internal"}}keystone.{{.Release.Namespace}}.svc.kubernetes.{{.Values.region}}.{{.Values.tld}}{{end}}

{{define "glance_api_endpoint_host_internal"}}glance.{{.Release.Namespace}}.svc.kubernetes.{{.Values.region}}.{{.Values.tld}}{{end}}

{{define "neutron_api_endpoint_host_internal"}}neutron-server.{{.Release.Namespace}}.svc.kubernetes.{{.Values.region}}.{{.Values.tld}}{{end}}

{{define "ironic_db_host"}}postgres-ironic.{{.Release.Namespace}}.svc.kubernetes.{{.Values.region}}.{{.Values.tld}}{{end}}
{{define "ironic_api_endpoint_host_admin"}}ironic-api.{{.Release.Namespace}}.svc.kubernetes.{{.Values.region}}.{{.Values.tld}}{{end}}
{{define "ironic_api_endpoint_host_internal"}}ironic-api.{{.Release.Namespace}}.svc.kubernetes.{{.Values.region}}.{{.Values.tld}}{{end}}
{{define "ironic_api_endpoint_host_public"}}baremetal-3.{{.Values.region}}.{{.Values.tld}}{{end}}

{{define "ironic_inspector_endpoint_host_admin"}}ironic-inspector.{{.Release.Namespace}}.svc.kubernetes.{{.Values.region}}.{{.Values.tld}}{{end}}
{{define "ironic_inspector_endpoint_host_internal"}}ironic-inspector.{{.Release.Namespace}}.svc.kubernetes.{{.Values.region}}.{{.Values.tld}}{{end}}
{{define "ironic_inspector_endpoint_host_public"}}baremetal-inspector-3.{{.Values.region}}.{{.Values.tld}}{{end}}
