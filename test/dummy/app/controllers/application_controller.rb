class ApplicationController < ActionController::Base
  
	protect_from_forgery

	#before_filter :authenticate_user!
	before_filter :banned?
	before_filter :set_user_return_to

	#This method is overriding /lib/simple_user/concerns/controllers/application_controller.rb, if you remove this method it is going to act with the default behaviour
	def set_user_return_to
		url = request.referer
		namespace_name = url.split('/')[3] rescue ""
		req_action_name = url.split('/').last rescue ""
		logger.debug "SET USER RETURN TO ON 2: #{req_action_name}"

		if namespace_name != "simple_user" && req_action_name != "localhost:3000"
			session[:return_to] = request.referer
		end
	end

end