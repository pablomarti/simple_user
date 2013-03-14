module SimpleUser
  
  require 'rubygems'
  require 'devise'
  require 'cancan'
  require 'rolify'
  require 'omniauth'
  require 'omniauth-facebook'
  require 'simple_form'

  class Engine < ::Rails::Engine
    isolate_namespace SimpleUser
    
    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'fb_config.yml')
      YAML.load(File.open(env_file)).each do |key, value|
        ENV[key.to_s] = value.to_s
      end if File.exists?(env_file)
    end
  end
end
