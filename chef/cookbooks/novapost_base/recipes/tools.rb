# Packages.
package_list = [
  'bash-completion',
  'build-essential',
  'curl',
  'emacs',
  'file',
  'htop',
  'iftop',
  'iotop',
  'iptables',
  'less',
  'locate',
  'openssh-server',
  'openssh-client',
  'rsync',
  'screen',
  'sudo',
  'tcpdump',
  'vim',
  'wget',
  'zsh',
]
for package_name in package_list do
  package package_name do
    action :install
  end
end

# Delayed update of locate database.
execute "updatedb" do
  action :nothing
  subscribes :run, resources(:package => "locate"), :delayed
end
