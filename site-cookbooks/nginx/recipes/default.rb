include_recipe "yum-epel"

package "nginx" do
  action :install
end

service "nginx" do
  action [:enable]
  supports :start => true, :status => true, :restart => true, :reload => true
end
template "/etc/nginx/nginx.conf" do
  owner 'root'
  group 'root'
  mode 0644
end

template "/etc/nginx/conf.d/my-blog.conf" do
  owner 'root'
  group 'root'
  mode 0644
end


template "/etc/init.d/nginx" do
  source "nginx_app.erb"
  owner 'root'
  group 'root'
  mode "0755"
end

