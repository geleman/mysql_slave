# encoding: utf-8

require 'chefspec'
require 'spec_helper'

describe 'mysql_slave::default' do
  before do
    stub_data_bag_item('mysql', 'master').and_return({ id: 'mysql', password: 'test' })
    stub_data_bag_item('mysql', 'slave').and_return({ id: 'mysql', password: 'test' })
    stub_data_bag_item('mysql', 'replication').and_return({ id: 'mysql', password: 'test' })
    stub_command("mysql -uroot -ptest -S /tmp/mysqld.sock -e
    'select * from information_schema.global_status where variable_name like \"slave_running\";' | grep ON").and_return(true)
    stub_command("/usr/sbin/httpd -t").and_return(true)
    stub_command("which sudo").and_return(true)
    stub_data_bag_item('users', 'fhanson').and_return({id: "fhanson", team: "test", ssh_keys: "derp_key", administrator: "true", group: "test" })
    stub_data_bag_item('users', 'rgindes').and_return({id: "rgindes", team: "test", ssh_keys: "derp_key", administrator: "true", group: "test" })
    stub_data_bag_item('users', 'jneves').and_return({id: "jneves", team: "test", ssh_keys: "derp_key", administrator: "true", group: "test" })
    stub_data_bag_item('users', 'jcrawford').and_return({id: "jcrawford", team: "test", ssh_keys: "derp_key", administrator: "true", group: "test" })
    stub_data_bag_item('users', 'blieberman').and_return({id: "blieberman", team: "test", ssh_keys: "derp_key", administrator: "true", group: "test" })
    stub_data_bag_item('users', 'akemner').and_return({id: "akemner", team: "test", ssh_keys: "derp_key", administrator: "true", group: "test" })
    stub_data_bag_item('users', 'nessus').and_return({id: "nessus", team: "test", ssh_keys: "derp_key", administrator: "true", group: "test" })
  end

  let(:default) { ChefSpec::SoloRunner.converge('mysql_slave::default') }

    it 'includes recipe gdp-base-linux' do
      expect(default).to include_recipe('gdp-base-linux')
    end

    it 'includes recipe selinux::permissive' do
      expect(default).to include_recipe('selinux::permissive')
    end

    it 'includes recipe mysql_config::mysql_user' do
      expect(default).to include_recipe('mysql_config::mysql_user')
    end

    it 'includes recipe mysql_config::limits' do
      expect(default).to include_recipe('mysql_config::limits')
    end

    it 'includes recipe mysql_config::datafiles' do
      expect(default).to include_recipe('mysql_config::datafiles')
    end

    it 'includes recipe mysql_config::logfiles' do
      expect(default).to include_recipe('mysql_config::logfiles')
    end

    it 'includes recipe mysql_config::tmpdir' do
      expect(default).to include_recipe('mysql_config::tmpdir')
    end

    it 'includes recipe mysql_config::scheduler' do
      expect(default).to include_recipe('mysql_config::scheduler')
    end

    it 'includes recipe mysql_config::mysqldb' do
      expect(default).to include_recipe('mysql_config::mysqldb')
    end

    it 'includes recipe mysql_config::mysql2_gem' do
      expect(default).to include_recipe('mysql_config::mysql2_gem')
    end

    it 'includes recipe mysql_config::start_replication' do
      expect(default).to include_recipe('mysql_config::start_replication')
    end    
end
