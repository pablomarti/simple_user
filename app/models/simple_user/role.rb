module SimpleUser
	class Role < ActiveRecord::Base
	  
	  has_and_belongs_to_many :admin_users, :join_table => :simple_user_users_roles
	  
	  belongs_to :resource, :polymorphic => true
	  
	  scopify

	end
end