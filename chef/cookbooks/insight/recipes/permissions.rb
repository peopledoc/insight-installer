home = node['insight']['project_user']['home']
username = node['insight']['project_user']['username']

# Fix permissions.
permission_command_list = [
  "chown -R #{username}:#{username} #{home}/insight",
  "chmod -R u=rwX,g=rX,o=rX #{home}/insight",
  "chmod u=rwX,g=rX,o=rX #{home}/insight",
]
for permission_command in permission_command_list do
  execute permission_command do
    action :run
  end
end
