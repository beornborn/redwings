Rails.application.routes.draw do

  root :to => 'users#index'

  get 'password_resets/edit'

  get  'login'  => 'user_sessions#new',     :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout

<<<<<<< HEAD
  resources :users, only: [:index]
  resources :user_sessions, only: [:new, :create, :destroy]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :trello_backups, only: [:index, :create, :destroy]
=======
  namespace :services do
    resources :slack, only: [] do
      post :update_users, on: :collection
    end
  end

  resources :users
  resources :user_sessions
  resources :password_resets
>>>>>>> branch reload, check workability
end

