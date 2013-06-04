Rails.application.routes.draw do

  get "main/index"
  get "main/login"

  mount SimpleUser::Engine => "/simple_user", :as => "simple_user"
  mount Crimagify::Engine => "/crimagify", :as => "crimagify"

  get 'welcome/test_redirect'
  
  root :to => 'welcome#index'

end
