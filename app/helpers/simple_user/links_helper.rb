module SimpleUser
  module LinksHelper

	def login(label = "Login", options = {})
		link_to label, simple_user.new_user_session_path, options
	end
	
  end
end
