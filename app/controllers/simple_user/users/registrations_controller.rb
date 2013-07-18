module SimpleUser
	class Users::RegistrationsController < Devise::RegistrationsController

		  def after_sign_up_path_for(resource)
		  	if ENV['REDIRECT_USER_AFTER_SIGNIN'] == 'false' || !defined?(session[:return_to]) || session[:return_to] == "/" ||  session[:return_to].nil?
		    	after_sign_in_path_for(resource)
		    else
		    	return_to = session[:return_to]
		    	return_to
		    end
		  end

	end
end