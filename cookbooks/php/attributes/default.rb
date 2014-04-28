#	インストール設定

default['php']['version'] = "php-5.5.11"

default['php']['ref_name']    = "php"
default['php']['dir']         = "/usr/local/#{default['php']['ref_name']}"
#default['php']['install_dir'] = "/usr/local/#{default['php']['version']}"
default['php']['src_dir']     = "/usr/local/src"
default['php']['lib_dir']     = "/usr/local/lib/#{default['php']['ref_name']}"
default['php']['ini_dir']     = "/usr/local/lib"

default['php']['packages']    = %w[curl-devel openssl-devel libxml2 libxml2-devel re2c]
#default['php']['extensions']  = %w[apc.so memcached.so]
default['php']['extensions']  = []

default['php']['install_user']  = "root"
default['php']['install_group'] = "root"

default['php']['apatch_path'] = "/usr/local/apache2"

default['php']['configure'] = "--with-apxs2=#{default['php']['apatch_path']}/bin/apxs --enable-mbregex --with-iconv --enable-mbstring --with-mysql=mysqlnd --with-mysqli=mysqlnd --with-pdo-mysql=mysqlnd --enable-ftp --with-zlib --with-curl --with-mcrypt --with-openssl"


default['php']['include_files'] = []

default['php']['timezone'] = "Asia/Tokyo"


default['mcrypt']['version'] = "libmcrypt-2.5.8"
default['mcrypt']['lib_dir'] = "/usr/local/lib"
#default['memcached']['version'] = "libmemcached-1.0.16"
default['memcached']['lib_dir'] = "/usr/local/lib"


