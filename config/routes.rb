SimpleUser::Engine.routes.draw do

  #Omniauth-Facebook for Users
  
  #Opt 2
  devise_for :users, {
    class_name: 'SimpleUser::User',
    path_names: {sign_in: "login", sign_out: "logout"}, 
    :path => "u", 
    :controllers => { :registrations => "simple_user/users/registrations", :sessions => "simple_user/users/sessions" },
    module: :devise
  }

  #Opt 1
  #scope '/simple_user'
  #  devise_for :users, :class_name => "SimpleUser::User", path_names: {sign_in: "login", sign_out: "logout"}, :path => "u", :controllers => { :registrations => "users/registrations", :sessions => "users/sessions" }
  #end
  
  #Opt 0
  #devise_for :users, :class_name => "SimpleUser::User", path_names: {sign_in: "login", sign_out: "logout"}, :path => "u", :controllers => { :registrations => "users/registrations", :sessions => "users/sessions" }
  match 'auth/:provider/callback', to: 'auth#create'
  match 'auth/failure', to: redirect('/')

  #Management of Users
  resources :users

  #Devise for Admins
  devise_for :admin_users, {
    :class_name => "SimpleUser::AdminUser", 
    path_names: {sign_in: "login", sign_out: "logout"}, 
    :path => "d", 
    :controllers => { :registrations => "simple_user/admin_users/registrations", :sessions => "simple_user/admin_users/sessions" },
    module: :devise
  }

  #Management of Admins
  resources :admin_users

end
