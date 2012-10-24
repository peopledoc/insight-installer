# Install system dependencies.
home = node['insight']['project_user']['home']
username = node['insight']['project_user']['username']

package_list = [
  'build-essential',
  'python-dev',
  'python-virtualenv',
  'python-pip',
]
for package_name in package_list do
  package package_name do
    action :install
  end
end

# Upgrade Pip and Virtualenv.
execute "sudo pip install -U pip==1.2.1" do
  creates "/usr/lib/pymodules/python2.6/pip-1.2.1.egg-info"
  action :run
end
execute "sudo pip install -U virtualenv==1.8.2" do
  creates "/usr/lib/pymodules/python2.6/virtualenv-1.8.2.egg-info"
  action :run
end
execute "virtualenv #{home}/insight" do
  user username
  group username
  creates "#{home}/insight/bin/activate"
  environment ({'HOME' => "#{home}"})
  action :run
end
