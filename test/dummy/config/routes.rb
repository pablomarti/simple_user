Rails.application.routes.draw do

  mount SimpleUser::Engine => "/simple_user", :as => "simple_user"

  root :to => 'welcome#index'

end
