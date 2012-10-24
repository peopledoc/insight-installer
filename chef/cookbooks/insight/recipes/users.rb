# Project user.
attributes = node['insight']['project_user']
username = attributes['username']
uid = attributes['uid']
gid = attributes['gid']
home = attributes['home']
copy_ssh_key = node['copy_ssh_key']

group username do
  gid gid
  system false
  action :create
end

user username do
  comment "Owner of Insight source files."
  uid uid
  gid gid
  home home
  shell "/bin/bash"
  system false
  action :create
end

directory home do
  owner username
  group username
  mode "0755"
  recursive false
  action :create
end

# Create user's SSH directory.
directory "#{home}/.ssh" do
  owner username
  group username
  mode "0755"
  recursive false
  action :create
end

file "#{home}/.ssh/authorized_keys" do
  owner username
  group username
  mode "0644"
  action :create
end
