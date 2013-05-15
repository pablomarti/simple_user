Rails.application.routes.draw do

  mount SimpleUser::Engine => "/simple_user", :as => "simple_user"

  get 'welcome/test_redirect'
  
  root :to => 'welcome#index'

end
