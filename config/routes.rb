Rails.application.routes.draw do
  
  root 'sessions#new'

  get 'password_resets/create'
  get 'password_resets/edit'
  get 'password_resets/update'

  get 'logout' => 'sessions#destroy', :as => 'logout'
  get 'login' => 'sessions#new',      :as => 'login'

  resources :users
  resources :sessions
  resources :password_resets
  
end
