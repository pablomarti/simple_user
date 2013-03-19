module SimpleUser
  class AdminUsers::SessionsController < Devise::SessionsController

    layout ENV['ADMIN_LAYOUT']

    protected

        def after_sign_in_path_for(resource)
          if resource.banned?
            sign_out resource
            flash.delete(:notice)
            flash[:error] = "This account has been suspended."
            root_path
          else
            ENV['ADMIN_PATH']
          end
        end

  end
end