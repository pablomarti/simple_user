module SimpleUser
	class AdminUsers::RegistrationsController < Devise::RegistrationsController

		layout ENV['ADMIN_LAYOUT']

	end
end