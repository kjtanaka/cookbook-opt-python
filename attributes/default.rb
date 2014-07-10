default['python']['version'] = "2.7.8"
#default['python']['version'] = "3.4.1"
default['python']['install_dir'] = "/opt"
default['python']['download_dir'] = "/root/source"
default['python']['download_url'] = "http://www.python.org/ftp/python/#{node['python']['version']}/Python-#{node['python']['version']}.tgz"

# Packages
case node['platform_family']
when 'rhel'
  default['python']['packages'] = %w[zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel]
end

# Environment Modules
default['python']['modulefiles_dir'] = "/opt/modules-3.2.10/Modules/3.2.10/modulefiles"
default['python']['default_version'] = node['python']['version']
