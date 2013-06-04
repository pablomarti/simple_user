require "simple_user/engine"

Dir[File.dirname(__FILE__) + "/simple_user/concerns/controllers/*.rb"].each{ |f| require "simple_user/concerns/controllers/#{File.basename(f, ".rb")}" }

module SimpleUser
end
