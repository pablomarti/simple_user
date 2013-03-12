module SimpleUser
	class Ability
	  include CanCan::Ability

	  def initialize(admin_user)
	  	admin_user ||= AdminUser.new

	    if admin_user.has_role? :admin
	    	can :manage, :all
	    else
		    if admin_user.has_role? :role_manager
		    	can :manage, AdminUser
		    	can :manage, Role
		    elsif admin_user.has_role? :admin_user_manager
		    	can :manage, AdminUser	    		
		    end

		    if admin_user.has_role? :user_manager
		    	can :manage, User    	
		    end
	    end
	  end

	end
end