require 'sidekiq/web'

Rails.application.routes.draw do
  mount Sidekiq::Web, at: '/sidekiq'

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

  resources :users, only: [:show, :index, :edit, :update] do
    post :quit_project, on: :member
    post :enter_project, on: :member
    put :update_goodbye_reason, on: :member
    get :edit_goodbye_reason, on: :member
  end

  resources :user_sessions,   only: [:new, :create, :destroy]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :trello_backups,  only: [:index, :create, :destroy]
end
