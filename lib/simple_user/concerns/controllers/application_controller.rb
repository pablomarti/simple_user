module SimpleUser
  module Concerns
    module Controllers
      module ApplicationController
        extend ActiveSupport::Concern

		included do
			#before_filter :authenticate_user!
			#before_filter :banned?
			#before_filter :set_user_return_to

			rescue_from CanCan::AccessDenied do |exception|
				flash[:error] = "Access denied"
				redirect_to root_url
			end
		end

	  	module ClassMethods
	  	end

	  	module InstanceMethods
			def set_user_return_to
				url = request.referer
				namespace_name = url.split('/')[3] rescue ""

				if namespace_name != "simple_user"
					session[:return_to] = request.referer
				end
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

      end
    end
  end
end