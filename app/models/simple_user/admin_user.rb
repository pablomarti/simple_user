module SimpleUser
  class AdminUser < ActiveRecord::Base

    rolify  
    #resourcify

    #has_and_belongs_to_many :roles, :join_table => :users_roles, :foreign_key => "user_id"
    #has_many :simple_user_users_roles, :foreign_key => :user_id
    #has_and_belongs_to_many :simple_user_roles, :join_table => :simple_user_users_roles
    
    #has_and_belongs_to_many :roles, :join_table => :simple_user_users_roles
=begin
    has_and_belongs_to_many :simple_user_roles, 
                            :class_name => "Role", 
                            :join_table => :simple_user_users_roles, 
                            :foreign_key => :simple_user_admin_user_id
=end    
    has_and_belongs_to_many :simple_user_admin_users, :join_table => :simple_user_users_roles

    # Include default devise modules. Others available are:
    # :token_authenticatable, :confirmable,
    # :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable

    # Setup accessible (or protected) attributes for your model
    attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :active
    attr_accessible :temporal_roles
    attr_accessor :temporal_roles
    
    validates :email, :uniqueness => true
    validates :username, :uniqueness => true

    def get_roles
      @temporal_roles = roles.collect{ |role| role.name }.join(", ")
    end

    def banned?
      !active
    end

    def self.get_editable_admins_except(admin_id)
      joins(:roles).where("roles.name <> ? AND admin_users.id <> ?", "admin", admin_id).group(:id)
    end
    
  end
end
