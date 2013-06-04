module SimpleUser
	class ApplicationController < ::ApplicationController
		
		layout ENV['APPLICATION_LAYOUT']

		#before_filter :authenticate_user!
		before_filter :banned?
		before_filter :set_user_return_to

	end
end