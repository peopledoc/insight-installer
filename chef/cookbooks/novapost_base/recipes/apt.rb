# Make sure ``apt-get install`` and ``aptitude install`` don't automatically
# install recommended or suggested packages, i.e. install only what is
# required.
no_recommends_conf = "
APT::Install-Recommends \"0\";
APT::Install-Suggests \"0\";
"
file "/etc/apt/apt.conf.d/99z-without-recommends" do
  owner "root"
  group "root"
  mode "0644"
  content no_recommends_conf
  action :create
end

# Enable Debian backports.
source = "deb http://backports.debian.org/debian-backports squeeze-backports main"
file "/etc/apt/sources.list.d/20-debian-backports.list" do
  owner "root"
  group "root"
  mode "0644"
  content source
  action :create
  notifies :run, "execute[apt-get update]", :immediately
end

preferences = "
Package: redis-server
Pin: release a=squeeze-backports
Pin-Priority: 999
"
file "/etc/apt/preferences.d/20-redis-server" do
  owner "root"
  group "root"
  mode "0644"
  content preferences
  action :create
end

# Apt-get update.
execute "apt-get update" do
  action :nothing
end
