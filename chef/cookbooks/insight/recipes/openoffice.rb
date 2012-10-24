# Install system dependencies.
package_list = [
  'openoffice.org-headless',
  'openoffice.org',
  'openoffice.org-java-common',
]
for package_name in package_list do
  package package_name do
    action :install
  end
end

# Add openoffice to be lauch as a service
template "/etc/init.d/openoffice" do
  owner "root"
  group "root"
  mode "0755"
  source "openoffice.erb"
  action :create
  notifies :start, "service[openoffice]", :immediately
end

service "openoffice"
