module SimpleUser
  module ApplicationHelper

	def print_yes_or_no(value)
		value ? "Yes" : "No"
	end
	
	def link_to_login(label = "Login", options = {})
		link_to label, new_user_session_path, options
	end
	
  end
end
