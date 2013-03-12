module SimpleUser
  class Authentication < ActiveRecord::Base
    
    belongs_to :user
    
    attr_accessible :provider, :token, :uid, :user_id

  end
end
