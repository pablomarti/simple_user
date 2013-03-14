class Ability
  include CanCan::Ability

  def initialize(admin_user)
  	admin_user ||= SimpleUser::AdminUser.new

  	puts "ADMIN USER: #{admin_user.inspect}"

    if admin_user.has_role? :admin
    	can :manage, :all
    else
	    if admin_user.has_role? :role_manager
	    	can :manage, SimpleUser::AdminUser
	    	can :manage, Role
	    elsif admin_user.has_role? :admin_user_manager
	    	can :manage, SimpleUser::AdminUser	    		
	    end

	    if admin_user.has_role? :user_manager
	    	can :manage, SimpleUser::User    	
	    end
    end
  end

end