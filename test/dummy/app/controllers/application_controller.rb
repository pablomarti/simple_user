class ApplicationController < ActionController::Base
  
	protect_from_forgery

	#before_filter :authenticate_user!
	before_filter :banned?

	rescue_from CanCan::AccessDenied do |exception|
		flash[:error] = "Access denied"
		redirect_to root_url
	end

	def banned?
		if current_user.present? && current_user.banned?
		  sign_out current_user
	      flash.delete(:notice)
		  flash[:error] = "This account has been suspended."
		  root_path
		elsif current_admin_user.present? && current_admin_user.banned?
		  sign_out current_admin_user
	      flash.delete(:notice)
		  flash[:error] = "This account has been suspended."
		  root_path
		end
	end

	def current_ability
		@current_ability ||= Ability.new(current_admin_user)
	end

end
