module SimpleUser
  module Generators
    class GenerateViewsGenerator < ::Rails::Generators::Base
      source_root File.expand_path("../../../../../app/views", __FILE__)
      desc "Generate Views of Simple User"

      def copy_views
        directory "simple_user", "app/views/simple_user"
      end      
    end
  end
end