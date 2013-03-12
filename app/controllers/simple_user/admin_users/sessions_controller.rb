module SimpleUser
  class AdminUsers::SessionsController < Devise::SessionsController

    protected

        def after_sign_in_path_for(resource)
          if resource.banned?
            sign_out resource
            flash.delete(:notice)
            flash[:error] = "This account has been suspended."
            root_path
          else
            super
          end
        end

  end
end