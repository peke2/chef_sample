#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

%w{wget tar gcc gcc-c++}.each{|pkg|
	package pkg do
		action :install
	end
}

