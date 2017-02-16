[DEFAULT]
debug = {{.Values.debug}}
syslog_log_facility=LOG_LOCAL0
use_syslog=yes
#admin_token =
enabled_drivers=pxe_ipmitool,agent_ipmitool
network_provider=neutron_plugin

enabled_network_interfaces=noop,flat,neutron
default_network_interface=neutron

[ironic]
os_region= {{.Values.region}}
auth_url = {{.Values.keystone.api_endpoint_protocol_admin}}://{{include "keystone_api_endpoint_host_admin" .}}:{{ .Values.keystone.api_port_admin }}/v3
auth_type = password
username = {{ .Values.ironic.service_user }}
password = {{ .Values.ironic.service_password }}

[dhcp]
dhcp_provider=none

[api]
host_ip = 0.0.0.0

[firewall]
manage_firewall=False

[processing]
always_store_ramdisk_logs=true
ramdisk_logs_dir=/var/log/ironic-inspector/
add_ports=all
keep_ports=all
ipmi_address_fields=ilo_address
enable_setting_ipmi_credentials=true
log_bmc_address=true
node_not_found_hook=enroll
default_processing_hooks=ramdisk_error,root_disk_selection,scheduler,validate_interfaces,capabilities,pci_devices,extra_hardware
processing_hooks=$default_processing_hooks, local_link_connection

[discovery]
enroll_node_driver=agent_ipmitool

[database]
connection = postgresql://{{.Values.database.db_user}}:{{.Values.database.db_password}}@{{include "ironic_db_host" .}}:{{.Values.postgres.port_public}}/{{.Values.database.db_name}}

[keystone_authtoken]
auth_uri = {{.Values.keystone.api_endpoint_protocol_internal}}://{{include "keystone_api_endpoint_host_internal" .}}:{{ .Values.keystone.api_port_internal }}
auth_url = {{.Values.keystone.api_endpoint_protocol_admin}}://{{include "keystone_api_endpoint_host_admin" .}}:{{ .Values.keystone.api_port_admin }}/v3
auth_type = password
username = {{ .Values.ironic.service_user }}
password = {{ .Values.ironic.service_password }}

memcache_servers = {{include "memcached_host" .}}:{{.Values.memcached.port_public}}
region_name = {{.Values.region}}
insecure = True

{{include "oslo_messaging_rabbit" .}}

[oslo_middleware]
enable_proxy_headers_parsing = True
