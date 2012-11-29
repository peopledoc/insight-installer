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
  to "/var/lib/gems/1.9.1/bin/docsplit"
end


# Generate Circus configuration.
template "#{home}/insight/etc/circus/circus_insight.ini" do
  owner username
  group username
  mode "0644"
  source "circus_insight.erb"
  variables({:stderr_log_file => node['insight']['circus']['stderr_log_file'],
             :stdout_log_file => node['insight']['circus']['stdout_log_file'],
             :redis_queue_keys => node['insight']['redis']['redis_queue_keys'],
             :user => node['insight']['project_user']['username']})
  action :create
end

# Install 2.6 requirements
execute "#{home}/insight/bin/pip install subprocess32" do
  user username
  group username
  environment ({'HOME' => "#{home}"})
  action :run
end

# Install insight in the venv
execute "#{home}/insight/bin/python setup.py develop" do
  user username
  group username
  cwd "#{home}/insight/"
  environment ({'HOME' => "#{home}"})
  action :run
end

# Patch entry point to use the etc/insight/settings.py file
template "#{home}/insight/bin/insight_api" do
  owner username
  group username
  mode "0755"
  source "insight_api.erb"
  variables({:home => "#{home}"})
  action :create
end

# Patch entry point to use the etc/insight/settings.py file
template "#{home}/insight/bin/insight" do
  owner username
  group username
  mode "0755"
  source "insight.erb"
  variables({:home => "#{home}"})
  action :create
end

# Setup the insight settings file
directory "#{home}/insight/etc/insight" do
  owner username
  group username
  mode "0755"
  recursive true
  action :create
end

template "#{home}/insight/etc/insight/settings.py" do
  owner username
  group username
  mode "0644"
  source "insight_settings.erb"
  variables({:insight_previews_url => node['insight']['previews']['url'],
             :insight_previews_root => node['insight']['previews']['root'],
             :redis_queue_keys => node['insight']['redis']['redis_queue_keys'],
             :default_redis_queue_key => node['insight']['redis']['default_redis_queue_key']})
  action :create
end


# Post-install.
include_recipe "insight::permissions"
