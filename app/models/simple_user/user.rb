module SimpleUser
  class User < ActiveRecord::Base

    include Crimagify::CrimagifyEnvs
    
    # has_many :crimagify_images, :as => :parent, :dependent => :destroy, :class_name => Crimagify::Image
    resourcify
    
    has_many :authentications, :dependent => :delete_all
    
    # Include default devise modules. Others available are:
    # :token_authenticatable, :confirmable,
    # :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable

    attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :first_name, :last_name, :active, :crimagify_schema
    #attr_accessible :current_password
    
    validates :email, :uniqueness => true
    validates :username, :uniqueness => true


    def self.build_new_auth(auth)
      email = ""

      if auth['provider'] == 'facebook'
        user = User.find_by_email(auth['extra']['raw_info']['email'])
      end

      user ||= User.new
      user.apply_omniauth(auth)
      return user
    end

    def apply_omniauth(auth)  
      #Generates random usernames and passwords for the first time
      if self.id.nil?
        tmp_password = generate_random(8)
        tmp_username = generate_random(6)
      end

      #Gets AUTH information
      if auth['provider'] == 'facebook'
        #Saves username and email for the first time
        if self.id.nil?
          tmp_username = auth['extra']['raw_info']['username'] rescue generate_random(6)
          self.email = auth['extra']['raw_info']['email']
        end

        self.first_name = auth['extra']['raw_info']['first_name'] if self.first_name.nil?
        self.last_name = auth['extra']['raw_info']['last_name'] if self.last_name.nil?
      end

      #Check if the username exists in the database and if it exists replace it with a new one, for the first time
      if self.id.nil?
        invalid_username = true

        while invalid_username
          tmp_user = User.find_by_username(tmp_username) rescue nil
          if tmp_user.nil?
            invalid_username = false
          else
            tmp_username = generate_random(6)
          end
        end
      end

      #Sets main values for the first time
      if self.id.nil?
        self.username = tmp_username
        self.password = tmp_password 
        self.password_confirmation = tmp_password
      end

      #Saves the authentication
      authentications.build(:provider => auth['provider'], :uid => auth['uid'], :token => auth['credentials']['token'])
    end

    def full_name
      first_name.to_s + " " + last_name.to_s
    end

    def banned?
      !active
    end

    def social_picture(provider = "facebook", width = 160, height = 129)
      auth = authentications.where(:provider => provider).first rescue nil

      tmp_image = case provider
            when "facebook"
                auth.nil? ? "" : "http://graph.facebook.com/#{auth.uid}/picture?width=#{width}&height=#{height}"
            else
                ""
      end

      return tmp_image
    end

    def profile_pic_thumb
      begin
        if crimagify_images.where('image <> ""').empty?
          social_picture("facebook", 150, 150)
        else
          imgA.thumb rescue social_picture("facebook", 150, 150)
        end
      rescue
        social_picture("facebook", 150, 150) rescue "crimagify/image_not_selected.jpg"
      end
    end

    def update_with_password(params={}) 
      if params[:password].blank? 
        params.delete(:password) 
        params.delete(:password_confirmation) if params[:password_confirmation].blank? 
      end 
      update_attributes(params) 
    end

    def update_without_password(params={})
        params.delete(:current_password)
        super(params)
    end

    private
      def generate_random(str_length)
        charlist = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
        generate_str = ""
        1.upto(str_length) {|i| generate_str << charlist[rand(charlist.size-1)]}
        return generate_str
      end

  end
end