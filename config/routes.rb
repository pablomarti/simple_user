SimpleUser::Engine.routes.draw do

  #Omniauth-Facebook for Users
  devise_for :users, :class_name => "SimpleUser::User", path_names: {sign_in: "login", sign_out: "logout"}, :path => "u", :controllers => { :registrations => "users/registrations", :sessions => "users/sessions" }
  match 'auth/:provider/callback', to: 'auth#create'
  match 'auth/failure', to: redirect('/')

  #Management of Users
  resources :users

  #Devise for Admins
  devise_for :admin_users, :class_name => "SimpleUser::AdminUser", path_names: {sign_in: "login", sign_out: "logout"}, :path => "d", :controllers => { :registrations => "admin_users/registrations", :sessions => "admin_users/sessions" }

  #Management of Admins
  resources :admin_users

end
