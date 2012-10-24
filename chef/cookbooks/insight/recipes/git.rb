username = node['insight']['project_user']['username']
home = node['insight']['project_user']['home']
git_host = node['insight']['git_host']
git_user = node['insight']['git_user']

# Install system dependencies.
package_list = [
  'git',
]
for package_name in package_list do
  package package_name do
    action :install
  end
end

# Configure git
git_host = "github.com"
git_user = "git"

# Create user's SSH directory.
directory "#{home}/.ssh" do
  owner username
  group username
  mode "0755"
  recursive false
  action :create
end

# Add github.com to known hosts.
template "#{home}/.ssh/known_hosts" do
  owner username
  group username
  mode "0600"
  source "known_hosts.erb"
  action :create
end
