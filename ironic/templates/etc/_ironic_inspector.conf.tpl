# Copyright 2017 The Openstack-Helm Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

[DEFAULT]
debug = {{ .Values.misc.debug }}
use_syslog = False
use_stderr = True

enabled_drivers=pxe_ipmitool,agent_ipmitool
# network_provider=neutron_plugin

# enabled_network_interfaces=noop,flat,neutron
# default_network_interface=neutron
enabled_network_interfaces=noop
default_network_interface=noop


[ironic]
auth_type = password
username = {{ .Values.ironic.service_user }}
password = {{ .Values.ironic.service_password }}

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
connection = mysql+pymysql://{{ .Values.database.ironic_user }}:{{ .Values.database.ironic_password }}@{{ .Values.database.address }}:{{ .Values.database.port }}/{{ .Values.database.ironic_database_name }}
max_retries = -1

[keystone_authtoken]
#auth_url = {{ include "helm-toolkit.endpoint_keystone_internal" . }}
auth_url = {{ .Values.keystone.auth_url }}
auth_type = password
project_domain_name = {{ .Values.keystone.ironic_project_domain }}
project_name = {{ .Values.keystone.ironic_project_name }}
user_domain_name = {{ .Values.keystone.ironic_user_domain }}
username = {{ .Values.keystone.ironic_user }}
password = {{ .Values.keystone.ironic_password }}

[oslo_messaging_rabbit]
rabbit_userid = {{ .Values.messaging.user }}
rabbit_password = {{ .Values.messaging.password }}
rabbit_ha_queues = true
rabbit_hosts = {{ .Values.messaging.hosts }}
