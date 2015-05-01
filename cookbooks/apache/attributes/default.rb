#	インストール設定

default['apache']['version'] = "httpd-2.2.24"

default['apache']['ref_name']    = "apache2"
default['apache']['dir']         = "/usr/local/#{default['apache']['ref_name']}"
default['apache']['install_dir'] = "/usr/local/#{default['apache']['version']}"
default['apache']['src_dir']     = "/usr/local/src"

default['apache']['install_user']  = "root"
default['apache']['install_group'] = "root"

default['apache']['packages'] = %w[openssl-devel]

default['apache']['configure'] = "--enable-ssl --enable-so --enable-rewrite --enable-dav --enable-dav-fs --prefix=#{default['apache']['install_dir']}"

default['apache']['include_files']   = %w{httpd-vhosts}
default['apache']['test_name']       = "lamp-test"
default['apache']['directory_index'] = "index.html index.php"

default['apache']['server_name']   = "localhost.localdomain"
default['apache']['document_root'] = "/var/www"
#default['apache']['test_document_base'] = "/var/vagrant"
#default['apache']['test_document_root'] = "#{default['apache']['test_document_base']}/#{default['apache']['test_name']}"




