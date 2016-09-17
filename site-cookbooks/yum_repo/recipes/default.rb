# epel
package 'epel-release.noarch' do
  action :install
end

# remi
remote_file "#{Chef::Config[:file_cache_path]}/remi-release-6.rpm" do
    source "http://rpms.famillecollet.com/enterprise/remi-release-6.rpm"
    not_if "rpm -qa | grep -q '^remi-release'"
    action :create
    notifies :install, "rpm_package[remi-release]", :immediately
end

rpm_package "remi-release" do
    source "#{Chef::Config[:file_cache_path]}/remi-release-6.rpm"
    action :nothing
end
