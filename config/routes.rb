Rails.application.routes.draw do

  root :to => 'users#index'

  get 'password_resets/edit'

  get  'login'  => 'user_sessions#new',     :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout

  namespace :services do
    resources :slack, only: [] do
      post :update_users, on: :collection
    end
  end

  resources :users
  resources :user_sessions
  resources :password_resets
end

