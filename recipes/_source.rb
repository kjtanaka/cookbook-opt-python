#
# Cookbook Name:: python
# Recipe:: _source
# Author:: Koji Tanaka (<kj.tanaka@gmail.com>)
#
# Copyright 2014, FutureGrid Project, Indiana University
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
#

node['python']['packages'].each do |pkg|
  package pkg do
    action :install
  end
end

directory node['python']['install_dir'] do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

directory node['python']['download_dir'] do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

remote_file "#{node['python']['download_dir']}/Python-#{node['python']['version']}.tgz" do
  source node['python']['download_url']
  owner "root"
  group "root"
  mode "0644"
  action :create_if_missing
end

execute "extract_tarball" do
  cwd node['python']['download_dir']
  command "tar zxf Python-#{node['python']['version']}.tgz"
  creates "Python-#{node['python']['version']}"
end

script "make_install" do
  interpreter "bash"
  cwd "#{node['python']['download_dir']}/Python-#{node['python']['version']}"
  code <<-EOH
  ./configure --prefix=#{node['python']['install_dir']}/python-#{node['python']['version']}
  make
  make install
  EOH
  creates "#{node['python']['install_dir']}/python-#{node['python']['version']}"
end

