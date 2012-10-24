include_recipe "novapost_base::apt"
include_recipe "novapost_base::tools"
include_recipe "novapost_base::sftp"
include_recipe "insight::users"
include_recipe "insight::git"
include_recipe "insight::nginx"

home = node['insight']['project_user']['home']
username = node['insight']['project_user']['username']
insight_repository = "git://github.com/novagile/insight-reloaded.git"

# Clone insight repository.
execute "git clone #{insight_repository} #{home}/insight" do
  creates "#{home}/insight/.gitignore"
  action :run
end

# Create/configure directories.
dir_list = [
  'insight',
  'insight/etc',
  'insight/etc/circus',
]
for dir_name in dir_list do
  directory "#{home}/#{dir_name}" do
    owner username
    group username
    mode "0755"
    action :create
  end
end
