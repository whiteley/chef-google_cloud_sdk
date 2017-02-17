#
# Cookbook:: google_cloud_sdk
# Resource:: install
#
# Copyright:: 2017, Matt Whiteley
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

property :app_engine_java, [TrueClass, FalseClass], default: false
property :app_engine_python, [TrueClass, FalseClass], default: false
property :bigtable_emulator, [TrueClass, FalseClass], default: false
property :datastore_emulator, [TrueClass, FalseClass], default: false
property :pubsub_emulator, [TrueClass, FalseClass], default: false
property :kubectl, [TrueClass, FalseClass], default: false

action :create do
  case node['platform_family']
  when 'debian'
    apt_repository 'google-cloud-sdk' do
      uri 'http://packages.cloud.google.com/apt'
      distribution "cloud-sdk-#{node['lsb']['codename']}"
      components %w( main )
      key 'https://packages.cloud.google.com/apt/doc/apt-key.gpg'
    end
  when 'rhel'
    yum_repository 'google-cloud-sdk' do
      description 'Google Cloud SDK'
      baseurl 'https://packages.cloud.google.com/yum/repos/cloud-sdk-el7-x86_64'
      gpgcheck true
      repo_gpgcheck true
      gpgkey %w(https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg)
    end
  end

  packages = %w(google_cloud_sdk)
  packages << 'google-cloud-sdk-app-engine-java' if new_resource.app_engine_java
  packages << 'google-cloud-sdk-app-engine-python' if new_resource.app_engine_python
  packages << 'google-cloud-sdk-bigtable-emulator' if new_resource.bigtable_emulator
  packages << 'google-cloud-sdk-datastore-emulator' if new_resource.datastore_emulator
  packages << 'google-cloud-sdk-pubsub-emulator' if new_resource.pubsub_emulator
  packages << 'kubectl' if new_resource.kubectl

  package 'google-cloud-sdk-packages' do
    package_name packages
  end
end

action :delete do
  case node['platform_family']
  when 'debian'
    apt_repository 'google-cloud-sdk' do
      action :remove
    end
  when 'rhel'
    yum_repository 'google-cloud-sdk' do
      action :delete
    end
  end

  packages = %w(google_cloud_sdk)
  packages << 'google-cloud-sdk-app-engine-java' if new_resource.app_engine_java
  packages << 'google-cloud-sdk-app-engine-python' if new_resource.app_engine_python
  packages << 'google-cloud-sdk-bigtable-emulator' if new_resource.bigtable_emulator
  packages << 'google-cloud-sdk-datastore-emulator' if new_resource.datastore_emulator
  packages << 'google-cloud-sdk-pubsub-emulator' if new_resource.pubsub_emulator
  packages << 'kubectl' if new_resource.kubectl

  package 'google-cloud-sdk-packages' do
    package_name packages
    action :remove
  end
end
