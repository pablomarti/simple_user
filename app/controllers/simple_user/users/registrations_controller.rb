module SimpleUser
	class Users::RegistrationsController < Devise::RegistrationsController

		  before_filter :set_user_return_to

		  def set_user_return_to
			  url = request.referer
			  namespace_name = url.split('/')[3] rescue ""

			  if namespace_name != "simple_user"
			    session[:return_to] = request.referer
			  end
		  end

		  def after_sign_up_path_for(resource)
		  	if ENV['REDIRECT_USER_AFTER_SIGNIN'] == 'false' || !defined?(session[:return_to]) || session[:return_to] == "/" ||  session[:return_to].nil?
		    	after_sign_in_path_for(resource)
		    else
		    	return_to = session[:return_to]
		    	session[:return_to] = "/"
		    	return_to
		    end
		  end

	end
end