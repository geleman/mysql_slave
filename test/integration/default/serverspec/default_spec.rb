require 'spec_helper'

describe selinux do
  it { should be_permissive }
end

describe command('cat /proc/sys/vm/swappiness') do
  its(:stdout) { should match '0' }
end

describe group('mysql') do
  it { should exist }
end

describe user('mysql') do
  it { should exist }
end

describe command('ulimit -Hn | grep 65536') do
  its(:exit_status) { should eq 0 }
end

describe command('ulimit -Sn | grep 65536') do
  its(:exit_status) { should eq 0 }
end

describe command('mount | grep -i /data') do
  its(:exit_status) { should eq 0 }
end

describe file('/data/mysql') do
  it { should be_directory }
  it { should be_mode 750 }
  it { should be_owned_by 'mysql' }
  it { should be_grouped_into 'mysql' }
end

describe command('mount | grep -i /logs') do
  its(:exit_status) { should eq 0 }
end

describe file('/logs/mysql') do
  it { should be_directory }
  it { should be_mode 750 }
  it { should be_owned_by 'mysql' }
  it { should be_grouped_into 'mysql' }
end

describe file('/logs/mysql/bin-logs') do
  it { should be_directory }
  it { should be_mode 750 }
  it { should be_owned_by 'mysql' }
  it { should be_grouped_into 'mysql' }
end

describe file('/logs/mysql/relay-logs') do
  it { should be_directory }
  it { should be_mode 750 }
  it { should be_owned_by 'mysql' }
  it { should be_grouped_into 'mysql' }
end

describe command('mount | grep -i /dev/shm') do
  its(:exit_status) { should eq 1 }
end

describe file('/tmp/shm') do
  it { should be_directory }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe command('mount | grep -i /tmp/shm') do
  its(:exit_status) { should eq 0 }
end

describe command('cat /sys/block/sdb/queue/scheduler | awk \'NR>1{print $1}\' RS=[ FS=] | grep -i deadline') do
  its(:exit_status) { should eq 0 }
end

describe file('/etc/iptables.d/mysql') do
  it { should be_file }
  it { should be_mode 644 }
end

describe iptables do
  it { should have_rule('-A FWR -p tcp -m tcp --dport 3306 -j ACCEPT') }
end

describe package('mysql-community-server') do
  it { should be_installed }
end

describe file('/logs/mysql') do
  it { should be_directory }
  it { should be_owned_by 'mysql' }
  it { should be_grouped_into 'mysql' }
end

describe file('/etc/mysql-master/conf.d/master.cnf') do
  it { should be_file }
  it { should be_owned_by 'mysql' }
  it { should be_grouped_into 'mysql' }
  it { should be_mode 640 }
end

describe service('mysql') do
  it { should be_running }
end

describe file('/data/mysql/ib_logfile*') do
  it { should_not exist }
end

describe command('/opt/chef/embedded/bin/gem list mysql2 | grep -i mysql2') do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match("mysql2 (0.3.17)\n") }
end

describe command('mysql -uroot -pslave_pass -S /tmp/mysqld.sock -e "select * from information_schema.global_status where variable_name like \'slave_running\';" | grep ON') do
  its(:exit_status) { should eq 0 }
end
