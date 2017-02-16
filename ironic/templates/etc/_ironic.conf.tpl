[DEFAULT]
debug = {{.Values.debug}}
syslog_log_facility=LOG_LOCAL0
use_syslog=yes
#admin_token =
enabled_drivers=pxe_ipmitool,agent_ipmitool
network_provider=neutron_plugin

enabled_network_interfaces=noop,flat,neutron
default_network_interface=neutron

rpc_response_timeout = {{ .Values.ironic.rpc_response_timeout | default 60 }}
rpc_workers = {{ .Values.ironic.rpc_workers | default 1 }}

[dhcp]
dhcp_provider=none

[api]
host_ip = 0.0.0.0

[conductor]
api_url = {{.Values.ironic.api_endpoint_protocol_internal}}://{{include "ironic_api_endpoint_host_internal" .}}:{{ .Values.ironic.api_port_internal }}
clean_nodes = false


[database]
connection = postgresql://{{.Values.database.db_user}}:{{.Values.database.db_password}}@{{include "ironic_db_host" .}}:{{.Values.postgres.port_public}}/{{.Values.database.db_name}}

[keystone_authtoken]
auth_uri = {{.Values.keystone.api_endpoint_protocol_internal}}://{{include "keystone_api_endpoint_host_internal" .}}:{{ .Values.keystone.api_port_internal }}
auth_url = {{.Values.keystone.api_endpoint_protocol_admin}}://{{include "keystone_api_endpoint_host_admin" .}}:{{ .Values.keystone.api_port_admin }}/v3
auth_type = password

username = {{ .Values.ironic.service_user }}
password = {{ .Values.ironic.service_password }}

memcache_servers = {{include "memcached_host" .}}:{{.Values.memcached.port_public}}
insecure = True

[glance]
glance_host = {{.Values.glance.api_endpoint_protocol_internal}}://{{include "glance_api_endpoint_host_internal" .}}:{{.Values.glance.api_port_internal}}
auth_strategy=keystone

[neutron]
url = {{.Values.neutron.api_endpoint_protocol_internal}}://{{include "neutron_api_endpoint_host_internal" .}}:{{ .Values.neutron.api_port_internal }}

{{include "oslo_messaging_rabbit" .}}

[oslo_middleware]
enable_proxy_headers_parsing = True