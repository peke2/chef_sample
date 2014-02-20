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


bash "install apache" do
	user	node['apache']['install_user']
	cwd		node['apache']['src_dir']
	not_if	"ls #{node['apache']['dir']}"

	#「bash」と「[」の間は空けないこと！！！
	notifies	:run, 'bash[start apache]', :immediately
	code	<<-EOH
		tar xzf #{node['apache']['version']}.tar.gz
		cd #{node['apache']['version']}
		./configure #{node['apache']['configure']}
		make
		make install
		ln -s #{node['apache']['install_dir']} #{node['apache']['dir']}
		chmod 744 /etc/init.d/httpd
		chkconfig --add httpd
		chkconfig --level 35 httpd on
		mkdir #{node['apache']['document_root']}
		chmod 777 #{node['apache']['document_root']}
	EOH
end


template "#{node['apache']['dir']}/conf/httpd.conf" do
	source	"httpd.conf.erb"
	owner	node['apache']['install_user']
	group	node['apache']['install_group']
	mode	0644
	notifies	:run, 'bash[restart apache]', :immediately
end


for include_file in node['apache']['include_files']
	template "#{node['apache']['dir']}/conf/extra/#{include_file}.conf"  do
		source	"#{include_file}.conf.erb"
		owner	node['apache']['install_user']
		group	node['apache']['install_group']
		mode	0644
		notifies	:run, 'bash[restart apache]', :immediately
	end
end


bash "start apache" do
	action	:nothing
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

