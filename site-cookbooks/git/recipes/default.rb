install_dir = '/usr/local/src'
version     = node['git']['version']
source_uri  = node['git']['source_uri']
configure   = node['git']['configure']
 
node['git']['packages'].each do |package_name|
  package "#{package_name}" do
    :install
  end
end
 
remote_file "/tmp/git-#{version}.tar.gz" do
  not_if 'which git'
  source "#{source_uri}"
end
 
bash 'install_git' do
  not_if 'which git'
  user 'root'
  code <<-EOL
    sudo install -d #{install_dir}
    sudo tar -zxvf /tmp/git-#{version}.tar.gz -C #{install_dir}
    cd #{install_dir}/git-#{version}
    sudo #{configure} && make && make install
  EOL
end
 
bash 'config_git' do
  user 'root'
   
  code <<-EOL
    git config --global core.editor 'vi -c "set fenc=utf-8"'
    git config --global color.diff auto
    git config --global color.status auto
    git config --global color.branch auto
    git config --global core.precomposeunicode true
    git config --global core.quotepath false
    git config --global alias.b branch
    git config --global alias.co checkout
  EOL
end
