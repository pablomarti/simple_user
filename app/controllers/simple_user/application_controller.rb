module SimpleUser
	class ApplicationController < ::ApplicationController
		
		layout ENV['APPLICATION_LAYOUT']

		before_filter :set_user_return_to

		def set_user_return_to
			session[:return_to] = request.referer
		end

	end
end