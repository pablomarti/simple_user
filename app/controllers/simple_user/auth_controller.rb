module SimpleUser
  class AuthController < ApplicationController

    def create
      logger.debug "--------------------------------------------- REQUEST"
      logger.debug request.inspect

      logger.debug "--------------------------------------------- REQUEST ENV"
      logger.debug request.env.inspect

      logger.debug "--------------------------------------------- REQUEST ENV OMNIAUTH"
      logger.debug request.env["omniauth"].inspect

      logger.debug "--------------------------------------------- REQUEST ENV OMNIAUTH-AUTH"
      logger.debug request.env["omniauth.auth"].inspect


      auth = request.env["omniauth.auth"]   
      logger.debug "AUTH: #{auth.inspect}"
      authentication = Authentication.find_by_provider_and_uid(auth['provider'], auth['uid'])
     
      if authentication
        flash[:notice] = "Signed in successfully."
        sign_in(:user, authentication.user)
        redirect_to root_url
      else
        user = User.build_new_auth(auth)
        #user.apply_omniauth(auth)
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