#	インストール設定

default['redis']['version'] = "redis-2.8.12"

default['redis']['ref_name']    = "redis"
default['redis']['dir']         = "/usr/local/#{default['redis']['ref_name']}"
#default['redis']['install_dir'] = "/usr/local/#{default['redis']['version']}"
default['redis']['src_dir']     = "/usr/local/src"
default['redis']['lib_dir']     = "/usr/local/lib/#{default['redis']['ref_name']}"
default['redis']['ini_dir']     = "/usr/local/lib"

#default['redis']['packages']    = %w[curl-devel openssl-devel libxml2 libxml2-devel re2c]
default['redis']['packages']    = []
#default['redis']['extensions']  = %w[apc.so memcached.so]
default['redis']['extensions']  = []

default['redis']['install_user']  = "root"
default['redis']['install_group'] = "root"

default['redis']['configure'] = ""

default['phpredis']['configure']     = ""
default['phpredis']['ref_name']      = "phpredis"
default['phpredis']['version']       = "#{default['phpredis']['ref_name']}-2.2.5"

default['phpredis']['dir']           = "/usr/local/#{default['phpredis']['ref_name']}"
default['phpredis']['src_dir']       = "/usr/local/src"
default['phpredis']['install_user']  = "root"
default['phpredis']['install_group'] = "root"

