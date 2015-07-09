Rails.application.routes.draw do

  root :to => 'static_pages#home'

  get 'password_resets/edit'

  get  'login'  => 'user_sessions#new',     :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout

  resources :users, only: [:index]
  resources :user_sessions, only: [:new, :create, :destroy]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :trello_backups, only: [:index, :create, :destroy]
end
