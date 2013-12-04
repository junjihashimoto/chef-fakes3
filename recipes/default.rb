#
# Cookbook Name:: fakes3
# Recipe:: default
#
# CC0 1.0 Universal (CC0 1.0)
# Public Domain Dedication
# You can copy, modify, distribute and perform the work, even for
# commercial purposes, all without asking permission.
#
directory "/srv/s3" do
  owner "vagrant"
  group "vagrant"
  mode 0755
  action :create
end

gem_package "fakes3" do
  action :install
end

execute "link_fakes3" do
  command "ln -s `which fakes3` /usr/local/bin/fakes3"
  creates "/usr/local/bin/fakes3"
end

template "fakes3.upstart.conf" do
  path "/etc/init/fakes3.conf"
  source "fakes3.upstart.conf.erb"
  owner "root"
  group "root"
  mode 0644
end

service "fakes3" do
  provider Chef::Provider::Service::Upstart
  supports :restart => true, :start => true, :stop => true
  action [:enable, :start]
end
