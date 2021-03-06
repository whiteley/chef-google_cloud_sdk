#
# Cookbook:: google_cloud_sdk
# Recipe:: default
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

package 'google-cloud-sdk'
