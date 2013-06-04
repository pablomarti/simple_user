module SimpleUser
  class AuthController < ApplicationController

    def create
      auth = request.env["omniauth.auth"]   
      authentication = Authentication.find_by_provider_and_uid(auth['provider'], auth['uid'])
     
      if authentication
        flash[:notice] = "Signed in successfully."
        sign_in(:user, authentication.user)
        redirect_after_create     
      else
        user = User.build_new_auth(auth)
        if user.save(:validate => false)
          flash[:notice] = "Account created and signed in successfully."
          sign_in(:user, user)
          redirect_after_create
        else
          flash[:error] = "Error while creating the user account. Please try again."
          redirect_after_create
        end
      end
    end

    def redirect_after_create
      logger.debug "AuthController.redirect_after_create"
      logger.debug session[:return_to]
      if ENV['REDIRECT_USER_AFTER_SIGNIN'] == 'false' || !defined? session[:return_to] || session[:return_to] == "/" ||  session[:return_to].nil?
        session[:return_to] = "/"
        logger.debug "CHANGE #{session[:return_to]}"
        redirect_to root_url
      else
        return_to = session[:return_to]
        logger.debug "PRESERVES #{session[:return_to]}"
        session[:return_to] = "/"
        redirect_to return_to
      end   
    end

  end
end