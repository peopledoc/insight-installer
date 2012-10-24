include_recipe "insight::python"

home = node['insight']['project_user']['home']
username = node['insight']['project_user']['username']

# Install system dependencies.
package_list = [
  'libevent-dev',
  'libzmq-dev',
]
for package_name in package_list do
  package package_name do
    action :install
  end
end

directory "#{home}/insight/etc/circus" do
  owner username
  group username
  mode "0755"
  recursive true
  action :create
end

template "#{home}/insight/etc/circus/circus.ini" do
  owner username
  group username
  mode "0644"
  source "circus.erb"
  action :create
end

# Install circus
execute "#{home}/insight/bin/pip install circus Mako MarkupSafe bottle anyjson gevent gevent-socketio gevent_zeromq gevent-websocket greenlet beaker" do
  user username
  group username
  environment ({'HOME' => "#{home}"})
  action :run
end

# Install circushttpd dependencies
execute "#{home}/insight/bin/pip install Mako MarkupSafe bottle anyjson gevent gevent-socketio gevent_zeromq gevent-websocket greenlet beaker" do
  user username
  group username
  environment ({'HOME' => "#{home}"})
  action :run
end

template "/etc/init.d/circusd" do
  owner "root"
  group "root"
  mode "0755"
  source "circusd.erb"
  variables({:circus_home => "#{home}/insight"})
  action :create
end
