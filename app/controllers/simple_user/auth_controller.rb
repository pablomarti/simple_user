module SimpleUser
  class AuthController < ApplicationController

    def create
      auth = request.env["omniauth.auth"]   
      authentication = Authentication.find_by_provider_and_uid(auth['provider'], auth['uid'])
     
      if authentication
        flash[:notice] = "Signed in successfully."
        sign_in(:user, authentication.user)
        redirect_to root_url
      else
        user = User.build_new_auth(auth)
        if user.save(:validate => false)
          flash[:notice] = "Account created and signed in successfully."
          sign_in(:user, user)
          redirect_to root_url
        else
          flash[:error] = "Error while creating the user account. Please try again."
          redirect_to root_url
        end
      end
    end

  end
end