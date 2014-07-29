#
# Cookbook Name:: python
# Recipe:: setuptools
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

include_recipe "build-essential"

remote_file "#{node['python']['download_dir']}/ez_setup.py" do
  source "https://bootstrap.pypa.io/ez_setup.py"
  owner "root"
  group "root"
  mode "0644"
end

execute "install_setuptools" do
  user "root"
  cwd node['python']['download_dir']
  command "python ez_setup.py"
  environment(
    "PYTHONHOME" => "#{node['python']['install_dir']}/python-#{node['python']['version']}",
    "PATH" => "#{node['python']['install_dir']}/python-#{node['python']['version']}/bin:$PATH"
  )
end
