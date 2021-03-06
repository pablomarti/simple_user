module SimpleUser
  module Generators
    class InstallGenerator < ::Rails::Generators::Base
      source_root File.expand_path("../templates", __FILE__)
      desc "Install SimpleUser"

      def copy_config_file
        copy_file "fb_config.yml", "config/fb_config.yml"
        copy_file "devise_config.yml", "config/devise_config.yml"
        copy_file "simple_user.yml", "config/simple_user.yml"
      end

      def copy_migrations
      	rake "simple_user:install:migrations"
        generate "crimagify:install"
        SimpleUser::Engine.load_seed
      end
      
    end
  end
end