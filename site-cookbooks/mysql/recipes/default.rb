remote_file "#{Chef::Config[:file_cache_path]}/mysql-community-release-el6-5.noarch.rpm" do
  source 'http://repo.mysql.com/mysql-community-release-el6-5.noarch.rpm'
  action :create
end

rpm_package "mysql-community-release" do
  source "#{Chef::Config[:file_cache_path]}/mysql-community-release-el6-5.noarch.rpm"
  action :install
end

# install mysql community server
yum_package "mysql-community-server" do
  action :install
  version "5.6.15-1.el6"
  flush_cache [:before]
end

service "mysqld" do
  supports :status => true, :restart => true, :reload => true
  action [ :enable, :start ]
end

execute "mysql-create-user" do
  command <<-EOC
    mysql -u root --password=\"#{node['mysql']['rootpass']}\" -e \"
    CREATE DATABASE IF NOT EXISTS \\`#{node['mysql']['db']}\\`;
    GRANT ALL ON \\`#{node['mysql']['db']}\\`.* TO \\"#{node['mysql']['user_name']}\\"@'localhost' IDENTIFIED BY \\"#{node['mysql']['user_pass']}\\";
    GRANT ALL ON \\`#{node['mysql']['db']}\\`.* TO \\"#{node['mysql']['user_name']}\\"@'%' IDENTIFIED BY \\"#{node['mysql']['user_pass']}\\";
    FLUSH PRIVILEGES;
    \"
  EOC
end

