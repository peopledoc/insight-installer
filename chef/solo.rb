# chef-solo configuration.

# Setup directories.
chef_dir = File.absolute_path(File.dirname(__FILE__))
cfg_dir = chef_dir
data_dir = File.join('var', 'chef')

cookbook_path File.join(cfg_dir, 'cookbooks')
data_bag_path File.join(cfg_dir, 'data_bags')
file_cache_path File.join(data_dir, 'cache')
file_backup_path File.join(data_dir, 'backup')
json_attribs File.join(cfg_dir, 'solo.json')
