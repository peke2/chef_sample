#	インストール設定

default['mysql']['version'] = "mysql-5.6.13"


default['mysql']['ref_name']    = "mysql"
default['mysql']['src_dir']     = "/usr/local/src"

default['mysql']['dir']  = "/usr/local/#{default['mysql']['ref_name']}"

default['mysql']['install_user']  = "root"
default['mysql']['install_group'] = "root"


default['mysql']['configure'] = "-DEXTRA_CHARSETS=all -DMYSQL_USER=mysql -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DWITH_READLINE=1 -DWITH_INNOBASE_STORAGE_ENGINE=1"


default['mysql']['include_files'] = []


