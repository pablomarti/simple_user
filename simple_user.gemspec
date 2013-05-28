$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "simple_user/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "simple_user"
  s.version     = SimpleUser::VERSION
  s.authors     = ["Pablo Marti"]
  s.email       = ["pablo.marti89@gmail.com"]
  s.homepage    = "https://github.com/pablomarti/simple_user"
  s.summary     = "Manage users and admins with Devise and Omniauth-Facebook."
  s.description = "Make avaiable to your users for login with Devise or Facebook, and manage them and your admins. Each admin is related to roles with Rolify, and manages authorization with CanCan."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.12"
  s.add_dependency "devise"
  s.add_dependency "cancan"
  s.add_dependency "rolify"
  s.add_dependency "omniauth"
  s.add_dependency "omniauth-facebook", "1.4.0"
  s.add_dependency "simple_form"
  s.add_dependency "crimagify"#, :git => 'git://github.com/trejo08/Crimagify.git'
  s.add_dependency "better_errors"

  #s.add_development_dependency "mysql2"
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "jquery-rails"
  s.add_development_dependency "debugger"
  s.add_development_dependency "sass-rails"
end