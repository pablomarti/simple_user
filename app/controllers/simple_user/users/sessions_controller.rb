module SimpleUser
  class Users::SessionsController < Devise::SessionsController

    def set_user_return_to
      url = request.referer
      namespace_name = url.split('/')[3] rescue ""

      if namespace_name != "simple_user"
        session[:return_to] = request.referer
      end
    end

    def new
      set_user_return_to
      if ENV['REDIRECT_USER_AFTER_SIGNIN'] == 'false' || session[:return_to].nil?
        session[:return_to] = "/"
      end

      super
    end

    def create
      set_user_return_to
      self.resource = warden.authenticate!(auth_options)
      #self.resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
      set_flash_message(:notice, :signed_in) if is_navigational_format?
      sign_in(resource_name, resource)
      respond_with resource, :location => after_sign_in_path_for(resource)
    end

    #def failure
    	#return render :json => {:success => false, :errors => ["Login failed"]}
    #end

    protected
        def after_sign_in_path_for(resource)
          if resource.banned?
            sign_out resource
            flash.delete(:notice)
            flash[:error] = "This account has been suspended."
            root_path
          else
            puts "NO BANNED"
            puts "ENV['REDIRECT_USER_AFTER_SIGNIN'] = " + ENV['REDIRECT_USER_AFTER_SIGNIN']
            puts "!defined?(session[:return_to]) = " + !defined?(session[:return_to]).to_s
            puts "session[:return_to] = " + session[:return_to].to_s

            if ENV['REDIRECT_USER_AFTER_SIGNIN'] == 'false' || !defined?(session[:return_to]) || session[:return_to] == "/" ||  session[:return_to].nil?
              session[:return_to] = "/"
              super
            else
              return_to = session[:return_to]
              session[:return_to] = "/"
              return_to
            end
          end
        end

        def serialize_options(resource)
          methods = resource_class.authentication_keys.dup
          methods = methods.keys if methods.is_a?(Hash)
          methods << :password if resource.respond_to?(:password)
          { :methods => methods, :only => [:password] }
        end

        def auth_options
          { :scope => resource_name, :recall => "#{controller_path}#new" }
        end

  end
end