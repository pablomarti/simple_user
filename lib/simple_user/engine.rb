module SimpleUser
  
  require 'rubygems'
  require 'devise'
  require 'cancan'
  require 'rolify'
  require 'omniauth'
  require 'omniauth-facebook'
  require 'simple_form'

  class Engine < ::Rails::Engine
    isolate_namespace SimpleUser
  end
end
