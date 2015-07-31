Rails.application.routes.draw do

  root to: 'users#index'

  get 'password_resets/edit'

  get  'login'  => 'user_sessions#new',     as: :login
  post 'logout' => 'user_sessions#destroy', as: :logout

  namespace :services do
    resources :slack, only: [] do
      post :update_users, on: :collection
    end

    resources :trello, only: [] do
      post :update_users, on: :collection
    end
  end

  resources :users, only: [:index, :edit, :update]
  resources :user_sessions, only: [:new, :create, :destroy]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :trello_backups, only: [:index, :create, :destroy]
end

