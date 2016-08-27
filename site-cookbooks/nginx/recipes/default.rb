package "nginx" do
  action :install
  options "--enablerepo=nginx"
end

service "nginx" do
  #サーバの設定ファイルに文法エラーがある状態だと起動に失敗するため、:startを使わない
  #自作設定ファイルを設置する前に、パッケージデフォルトのまま起動してしまうため、:startを使わない
  action [:enable]
  supports :start => true, :status => true, :restart => true, :reload => true
end


template "/etc/nginx/nginx.conf" do
  owner 'root'
  group 'root'
  mode 0644
  notifies :start, 'service[nginx]'  # ←　ここで:start指令を送る
  notifies :reload, 'service[nginx]'
end
