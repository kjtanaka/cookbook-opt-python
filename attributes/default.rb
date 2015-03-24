default['opt-python']['version'] = "2.7.9"
default['opt-python']['install_dir'] = "/opt"
default['opt-python']['download_dir'] = "/tmp"
default['opt-python']['download_url'] = "http://www.python.org/ftp/python/#{node['opt-python']['version']}/Python-#{node['opt-python']['version']}.tgz"

# Additional recipes
default['opt-python']['include_recipes'] = %w[_pip _setuptools]

# Generate modulefile
default['opt-python']['gen_modulefile'] = false

# Packages
case node['platform_family']
when 'rhel'
  default['opt-python']['packages'] = %w[zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel]
when 'debian'
  default['opt-python']['packages'] = %w[libreadline-dev libsqlite3-dev libbz2-dev libssl-dev]
end
