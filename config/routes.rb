Rails.application.routes.draw do

  root :to => 'users#index'

  get 'password_resets/edit'

  post 'sync'   => 'users#sync',            :as => :sync
  get  'login'  => 'user_sessions#new',     :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout

  resources :users
  resources :user_sessions
  resources :password_resets

end

