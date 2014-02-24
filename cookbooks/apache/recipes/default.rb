#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


cookbook_file "#{node['apache']['src_dir']}/#{node['apache']['version']}.tar.gz" do
	mode 0644
end


cookbook_file "/etc/init.d/httpd" do
	source "httpd"
end


directory "#{node['apache']['test_document_root']}" do
	not_if	"ls #{node['apache']['test_document_root']}"
	owner	'vagrant'
	group	'vagrant'
	mode	'0777'
	action :create
end


bash "install apache" do
	user	node['apache']['install_user']
	cwd		node['apache']['src_dir']
	not_if	"ls #{node['apache']['dir']}"

	#「bash」と「[」の間は空けないこと！！！
#	notifies	:run, 'bash[start apache]', :immediately
	notifies	:run, 'bash[start apache]', :delayed

	code	<<-EOH
		tar xzf #{node['apache']['version']}.tar.gz
		cd #{node['apache']['version']}
		./configure #{node['apache']['configure']}
		make
		make install
		ln -sf #{node['apache']['install_dir']} #{node['apache']['dir']}
		chmod 744 /etc/init.d/httpd
		chkconfig --add httpd
		chkconfig --level 35 httpd on
		mkdir #{node['apache']['document_root']}
		chmod 777 #{node['apache']['document_root']}
	EOH
end


directory "#{node['apache']['dir']}/logs/#{node['apache']['test_name']}" do
	not_if	"ls #{node['apache']['dir']}/logs/#{node['apache']['test_name']}"
	owner	'root'
	group	'root'
	mode	'0777'
	action :create
end


template "#{node['apache']['dir']}/conf/httpd.conf" do
	source	"httpd.conf.erb"
	owner	node['apache']['install_user']
	group	node['apache']['install_group']
	mode	0644
#	notifies	:run, 'bash[restart apache]', :immediately
	notifies	:run, 'bash[restart apache]', :delayed
end


for include_file in node['apache']['include_files']
	template "#{node['apache']['dir']}/conf/extra/#{include_file}.conf"  do
		source	"#{include_file}.conf.erb"
		owner	node['apache']['install_user']
		group	node['apache']['install_group']
		mode	0644
	#	notifies	:run, 'bash[restart apache]', :immediately
		notifies	:run, 'bash[restart apache]', :delayed
	end
end


bash "start apache" do
	action	:nothing				#「:nothing」は直接実行されない
	code <<-EOH
		sudo /etc/init.d/httpd start
	EOH
end


bash "restart apache" do
	action	:nothing
	code <<-EOH
		sudo /etc/init.d/httpd restart
	EOH
end

