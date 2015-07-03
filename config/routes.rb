Rails.application.routes.draw do

  root :to => 'static_pages#home'

  get 'password_resets/edit'

  get  'users'  => 'users#index',           :as => :users
  post 'sync'   => 'users#sync',            :as => :sync
  get  'login'  => 'user_sessions#new',     :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout

  resources :users
  resources :user_sessions
  resources :password_resets
end

