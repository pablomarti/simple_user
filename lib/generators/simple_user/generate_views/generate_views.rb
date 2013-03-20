module SimpleUser
  module Generators
    class GenerateViewsGenerator < ::Rails::Generators::Base
      desc "Generate Views of Simple User"

      def copy_views
        copy_file "../../../app/views/simple_user/", "app/views/"
      end      
    end
  end
end