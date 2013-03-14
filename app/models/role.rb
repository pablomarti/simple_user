class Role < ActiveRecord::Base

=begin
  has_and_belongs_to_many :simple_user_admin_users, 
  						  :class_name => "AdminUser", 
  						  :join_table => :simple_user_users_roles, 
                          :foreign_key => :simple_user_role_id
  						  #:association_foreign_key => "simple_user_admin_user_id"
=end


  has_and_belongs_to_many :admin_users, :join_table => "users_roles"

  belongs_to :resource, :polymorphic => true
  
  scopify

end