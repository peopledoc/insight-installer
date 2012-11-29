# Install system dependencies.
package_list = [
  'nginx',
]
for package_name in package_list do
  package package_name do
    action :install
  end
end

# Create a configuration for nginx
template "/etc/nginx/sites-available/insight" do
  owner "root"
  group "root"
  mode "0644"
  source "nginx.erb"
  variables({:insight_previews_root => node['insight']['previews']['root']})
  action :create
  notifies :create, "link[/etc/nginx/sites-enabled/insight]", :immediately
end

link "/etc/nginx/sites-enabled/insight" do
  to "/etc/nginx/sites-available/insight"
  notifies :restart, "service[nginx]", :immediately
end

service "nginx"
