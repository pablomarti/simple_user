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

    config.generators.load_generators

    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'fb_config.yml')
      YAML.load(File.open(env_file)).each do |key, value|
        ENV[key.to_s] = value.to_s
      end if File.exists?(env_file)

      env_file = File.join(Rails.root, 'config', 'devise_config.yml')
      YAML.load(File.open(env_file)).each do |key, value|
        ENV[key.to_s] = value.to_s
      end if File.exists?(env_file)

      env_file = File.join(Rails.root, 'config', 'simple_user.yml')
      YAML.load(File.open(env_file)).each do |key, value|
        ENV[key.to_s] = value.to_s
      end if File.exists?(env_file)
    end

    initializer 'simple_user.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        helper SimpleUser::ApplicationHelper
      end
    end

    initializer 'simple_user.app_controller' do |app|
      ActiveSupport.on_load :action_controller do
        extend SimpleUser::Concerns::Controllers::ApplicationController::ClassMethods
        include SimpleUser::Concerns::Controllers::ApplicationController::InstanceMethods
      end
    end

    #config.to_prepare do
    #  ApplicationController.helper(ApplicationHelper)
    #end

    middleware.use OmniAuth::Builder do
      provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'], :scope => ENV['FACEBOOK_SCOPE']
    end

  end
end