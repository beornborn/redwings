Rails.application.routes.draw do

  root :to => 'users#index'

  get 'password_resets/edit'

  get  'login'  => 'user_sessions#new',     :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout
  post 'slack_sync' => 'slack#users_sync',  :as => :slack_sync

  resources :slack
  resources :users
  resources :user_sessions
  resources :password_resets

end

