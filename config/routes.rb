Rails.application.routes.draw do

  root to: 'users#index'

  get 'password_resets/edit'

  get  'login'  => 'user_sessions#new',     as: :login
  post 'logout' => 'user_sessions#destroy', as: :logout

  namespace :service do
    resource :slack, only: [] do
      post :sync, on: :collection
    end

    resource :trello, only: [] do
      post :sync, on: :collection
    end

    resource :heroku, only: [] do
      post :sync, on: :collection
    end
  end

  resources :users,           only: [:index, :edit, :update]
  resources :user_sessions,   only: [:new, :create, :destroy]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :trello_backups,  only: [:index, :create, :destroy]
end

