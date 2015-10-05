#
# Cookbook Name:: master_test
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

mysql_service node['master_test']['instance_name'] do
  port '3306'
  version '5.6'
  socket '/tmp/master_test.sock'
  pid_file '/tmp/master_test.pid'
  initial_root_password 'change_me'
  action [:create, :start]
end

mysql_config node['master_test']['instance_name'] do
  instance node['master_test']['instance_name']
  source 'default.erb'
  variables(
    server_id: '9999'
    )
  action :create
  notifies :restart, "mysql_service[#{node['master_test']['instance_name']}]", :immediately
end

bash 'create repl user' do
  user 'mysql'
  code <<-EOF
  mysql -uroot -pchange_me -S /tmp/master_test.sock -e "create user 'repl'@'10.84.%' identified by 'repl_2';"
  mysql -uroot -pchange_me -S /tmp/master_test.sock -e "grant replication slave on *.* to 'repl'@'10.84.%';"
  mysql -uroot -pchange_me -S /tmp/master_test.sock -e "flush privileges;"
  EOF
  action :run
end
