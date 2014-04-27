#
# Cookbook Name:: php
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

node['php']['packages'].each do |pkg|
	package pkg do
		action :install
	end
end


cookbook_file "#{node['php']['src_dir']}/#{node['mcrypt']['version']}.tar.gz" do
	mode 0644
end


bash "install mcrypt" do
	user	node['php']['install_user']
	cwd		node['php']['src_dir']
	not_if	"ls #{node['mcrypt']['lib']}/libmcrypt*"

	#「bash」と「[」の間は空けないこと！！！
	code	<<-EOH
		tar xzf #{node['mcrypt']['version']}.tar.gz
		cd #{node['mcrypt']['version']}
		./configure
		make
		make install
	EOH
end


cookbook_file "#{node['php']['src_dir']}/#{node['php']['version']}.tar.gz" do
	mode 0644
end


bash "install php" do
	user	node['php']['install_user']
	cwd		node['php']['src_dir']
	not_if	"ls #{node['php']['dir']}"

	#	apacheのレシピで定義される restart を呼び出す
	notifies	:run, 'bash[restart apache]', :immediately
	code	<<-EOH
		tar xzf #{node['php']['version']}.tar.gz
		cd #{node['php']['version']}
		./configure #{node['php']['configure']}
		make
		make install
	EOH
end


cookbook_file "#{node['php']['src_dir']}/#{node['memcached']['version']}.tar.gz" do
	mode 0644
end


bash "install libmemcached" do
	user	node['php']['install_user']
	cwd		node['php']['src_dir']
	not_if	"ls #{node['memcached']['lib']}/memcached*"

	#「bash」と「[」の間は空けないこと！！！
	code	<<-EOH
		tar xzf #{node['memcached']['version']}.tar.gz
		cd #{node['memcached']['version']}
		./configure
		make
		make install
	EOH
end


bash "install apc" do
	user	node['php']['install_user']
	cwd		node['php']['src_dir']
	not_if	"ls #{node['php']['lib_dir']}/extensions/*/apc.so"

	notifies	:run, 'bash[restart apache]', :immediately
	code	<<-EOH
		pecl channel-update pecl.php.net
		pecl install apc
	EOH
end


bash "install memcached" do
	user	node['php']['install_user']
	cwd		node['php']['src_dir']
	not_if	"ls #{node['php']['lib_dir']}/extensions/*/memcached.so"

	notifies	:run, 'bash[restart apache]', :immediately
	code	<<-EOH
		pecl channel-update pecl.php.net
		pecl install memcached-2.1.0
	EOH
end


template "#{node['php']['ini_dir']}/php.ini" do
	source	"php.ini.erb"
	owner	node['php']['install_user']
	group	node['php']['install_group']
	mode	0644
#	notifies	:run, 'bash[restart php]', :immediately
end


bash "start memcache" do
	action	:nothing
	code <<-EOH
		sudo /etc/init.d/memcached start
	EOH
end

