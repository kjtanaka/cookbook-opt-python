#
# Cookbook Name:: python
# Recipe:: default
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

include_recipe 'build-essential'

packages = %w[zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel]

packages.each do |pkg|
  package pkg do
    action :install
  end
end

directory "/opt" do
  owner "root"
  user "root"
  mode "0644"
  action :create
end

directory "/root/source" do
  owner "root"
  user "root"
  mode "0644"
  action :create
end

remote_file "/root/source/Python-2.7.8.tgz" do
  source "http://www.python.org/ftp/python/2.7.8/Python-2.7.8.tgz"
  owner "root"
  group "root"
  mode "0644"
  action :create_if_missing
end

execute "extract_tarball" do
  cwd "/root/source"
  command "tar zxf Python-2.7.8.tgz"
  creates "Python-2.7.8"
end

script "make_install" do
  interpreter "bash"
  cwd "/root/source/Python-2.7.8"
  code <<-EOH
  ./configure --prefix=/opt/python-2.7.8
  make
  make install
  EOH
  creates "/opt/python-2.7.8"
end

