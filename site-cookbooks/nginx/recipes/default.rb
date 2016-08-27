include_recipe "yum-epel"

package "nginx" do
  action :install
end

service "nginx" do
  #サーバの設定ファイルに文法エラーがある状態だと起動に失敗するため、:startを使わない
  #自作設定ファイルを設置する前に、パッケージデフォルトのまま起動してしまうため、:startを使わない
  action [:enable, :start]
  supports :status => true, :restart => true, :reload => true
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
