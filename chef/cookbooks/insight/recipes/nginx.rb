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
template "/etc/nginx/sites-available/default" do
  owner "root"
  group "root"
  mode "0644"
  source "nginx.erb"
  variables({:user_path => node['insight']['project_user']['home']})
  action :create
  notifies :create, "link[/etc/nginx/sites-enabled/default]", :immediately
end

link "/etc/nginx/sites-enabled/default" do
  to "/etc/nginx/sites-available/default"
  notifies :reload, "service[nginx]", :immediately
end

service "nginx"
