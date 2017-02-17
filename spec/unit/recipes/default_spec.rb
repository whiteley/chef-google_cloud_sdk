#
# Cookbook:: google_cloud_sdk
# Spec:: default
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

require 'spec_helper'

describe 'google_cloud_sdk::default' do
  context 'When all attributes are default, on CentOS 7.2' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.2.1511')
      runner.converge(described_recipe)
    end

    it 'installs the google-cloud-sdk' do
      expect(chef_run).to create_yum_repository('google-cloud-sdk')
      expect(chef_run).to install_package('google-cloud-sdk')
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end

  context 'When all attributes are default, on Ubuntu 16.04' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    it 'installs the google-cloud-sdk' do
      expect(chef_run).to add_apt_repository('google-cloud-sdk')
      expect(chef_run).to install_package('google-cloud-sdk')
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end
  end
end
