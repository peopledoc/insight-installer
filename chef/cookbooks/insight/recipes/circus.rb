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
execute "#{home}/insight/bin/pip install circus" do
  user username
  group username
  environment ({'HOME' => "#{home}"})
  action :run
end
