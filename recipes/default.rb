#
# Cookbook Name:: mysql_slave
# Recipe:: default
#
# Copyright (C) 2015 Greg Lane
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'gdp-base-linux'
include_recipe 'selinux::permissive'
include_recipe 'sysctl::apply'
include_recipe 'mysql_config::mysql_user'
include_recipe 'mysql_config::limits'
include_recipe 'mysql_config::datafiles'
include_recipe 'mysql_config::logfiles'
include_recipe 'mysql_config::tmpdir'
include_recipe 'mysql_config::scheduler'
include_recipe 'mysql_config::mysqldb'
include_recipe 'mysql_config::mysql2_gem'
include_recipe 'mysql_config::start_replication'
