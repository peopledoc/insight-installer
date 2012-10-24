package_list = ['openssh-server', 'libpam-umask', 'libpam-modules']
for package_name in package_list do
  package package_name do
    action :install
  end
end

template "/etc/pam.d/sshd" do
  owner "root"
  group "root"
  mode "0644"
  source "sshd_config.erb"
  action :create
end
