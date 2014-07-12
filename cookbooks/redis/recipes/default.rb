#
# Cookbook Name:: redis
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

node['redis']['packages'].each do |pkg|
	package pkg do
		action :install
	end
end


cookbook_file "#{node['redis']['src_dir']}/#{node['redis']['version']}.tar.gz" do
	mode 0644
end


bash "install redis" do
	user	node['redis']['install_user']
	cwd		node['redis']['src_dir']
	not_if	"ls #{node['redis']['dir']}"

	code	<<-EOH
		tar xzf #{node['redis']['version']}.tar.gz
		cd #{node['redis']['version']}
		make
		make install
		utils/install_server.sh
	EOH
end


cookbook_file "#{node['phpredis']['src_dir']}/#{node['phpredis']['version']}.tar.gz" do
	mode 0644
end


bash "install phpredis" do
	user	node['phpredis']['install_user']
	cwd		node['phpredis']['src_dir']
	not_if	"ls #{node['phpredis']['lib']}/libphpredis*"

	code	<<-EOH
		tar xzf #{node['phpredis']['version']}.tar.gz
		cd #{node['phpredis']['version']}
		phpize
		./configure
		make
		make install
	EOH
end



