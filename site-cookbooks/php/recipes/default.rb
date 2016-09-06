%w(php-fpm php-mysql php-mbstring php-gd).each do |p|
  package p do
    action :install
    options "--enablerepo=remi-php56"
  end
end


# ini の配置
template "timezone.ini" do
  path "/etc/php.d/timezone.ini"
  source "timezone.ini.erb"
  mode 0644
  notifies :restart, 'service[nginx]'
end


#template '/etc/php-fpm.d/www.conf' do
#  source 'www.conf.erb'
#  owner 'root'
#  group 'root'
#  mode '0644'
#end

template "/etc/init.d/php-fpm" do
  source "php-fpm_app.erb"
  owner 'root'
  group 'root'
  mode "0755"
end
