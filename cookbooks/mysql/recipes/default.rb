#
# Cookbook Name:: mysql
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

["cmake","ncurses-devel"].each do |pkg|
	package pkg do
		action :install
	end
end


cookbook_file "#{node['mysql']['src_dir']}/#{node['mysql']['version']}.tar.gz" do
	mode 0644
end


bash "install mysql" do
	user	node['mysql']['install_user']
	cwd		node['mysql']['src_dir']
	not_if	"ls #{node['mysql']['dir']}"

	#「bash」と「[」の間は空けないこと！！！
	notifies	:run, 'bash[start mysql]', :immediately
	code	<<-EOH
		groupadd mysql
		useradd -r -g mysql mysql
		tar xzf #{node['mysql']['version']}.tar.gz
		cd #{node['mysql']['version']}
		cmake . #{node['mysql']['configure']}
		make
		make install
		cd #{node['mysql']['dir']}
		chown -R mysql .
		chgrp -R mysql .
		scripts/mysql_install_db --user=mysql
		chown -R root .
		chown -R mysql data
		cp support-files/my-default.cnf /etc/my.cnf
		cp support-files/mysql.server /etc/init.d/mysql.server
		chkconfig --add mysql.server
	EOH
end


bash "start mysql" do
	action	:nothing
	code <<-EOH
		#sudo /etc/init.d/mysql.server start
		/etc/init.d/mysql.server start
	EOH
end


#bash "restart mysql" do
#	action	:nothing
#	code <<-EOH
#		sudo /etc/init.d/mysql.server restart
#	EOH
#end


