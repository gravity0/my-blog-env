%w[php].each do |p|
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
