# Project user.
default['insight']['project_user']['username'] = 'insight'
default['insight']['project_user']['uid'] = 501
default['insight']['project_user']['gid'] = 501
default['insight']['project_user']['home'] = '/home/insight'

# Preview configuration
default['insight']['previews']['root'] = '/home/insight/insight/var/previews'
default['insight']['previews']['url'] = 'http://34.34.34.10/previews'

# Circus Log's configuration
default['insight']['circus']['stderr_log_file'] = '/home/insight/insight/var/circus.log'
default['insight']['circus']['stdout_log_file'] = '/home/insight/insight/var/circus.log'

# Git.
default['insight']['git_host'] = 'github.com'
default['insight']['git_user'] = 'git'
