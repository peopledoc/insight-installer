include_recipe "insight::default"
include_recipe "insight::python"
include_recipe "insight::circus"
include_recipe "insight::openoffice"

home = node['insight']['project_user']['home']
username = node['insight']['project_user']['username']

# Install system dependencies.
package 'redis-server' do
  options "-t squeeze-backports"
  action :install
end
package_list = [
  'rubygems',
  'graphicsmagick',
  'poppler-utils',
  'pdftk',
  'ghostscript',
]
for package_name in package_list do
  package package_name do
    action :install
  end
end
gem_package "docsplit" do
  action :install
  notifies :create, "link[/usr/local/bin/docsplit]", :immediately
end

link "/usr/local/bin/docsplit" do
  to "/var/lib/gems/1.9*/bin/docsplit"
end


# Generate Circus configuration.
template "#{home}/insight/etc/circus/circus_insight.ini" do
  owner username
  group username
  mode "0644"
  source "circus_insight.erb"
  action :create
end
execute "#{home}/insight/bin/pip install subprocess32" do
  user username
  group username
  environment ({'HOME' => "#{home}"})
  action :run
end

# Post-install.
include_recipe "insight::permissions"
