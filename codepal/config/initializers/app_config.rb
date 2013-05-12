require 'ostruct'
require 'digest/md5'

if File.exists?("#{ENV['HOME']}/.app_config.yml")
  local_config = YAML::load_file("#{ENV['HOME']}/.app_config.yml")[Rails.env]
end
local_config ||= {}
CONFIG = YAML::load_file(File.join(Rails.root,"config","app_config.yml"))[Rails.env].merge(local_config)
