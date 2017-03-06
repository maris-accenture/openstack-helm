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

enabled_network_interfaces=noop
# enabled_network_interfaces=noop,flat,neutron
# default_network_interface=neutron
default_network_interface=noop

username = {{ .Values.ironic.service_user }}
password = {{ .Values.ironic.service_password }}

rpc_response_timeout = {{ .Values.ironic.rpc_response_timeout | default 60 }}
rpc_workers = {{ .Values.ironic.rpc_workers | default 1 }}

auth_strategy = keystone

[conductor]
api_url = {{.Values.ironic.api_endpoint_protocol_internal}}://{{include "ironic_api_endpoint_host_internal" .}}:{{ .Values.ironic.api_port_internal }}
clean_nodes = false

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

[oslo_middleware]
enable_proxy_headers_parsing = True
