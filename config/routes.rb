Rails.application.routes.draw do

  root 'static_pages#home'

  get 'static_pages/home'
  get 'static_pages/greeting'

  get 'session/new'

  get 'password_reset/new'
  get 'password_reset/edit'

  get  'login'  => 'session#new',     :as => :login
  post 'logout' => 'session#destroy', :as => :logout

  
  resources :users
  resources :sessions
  resources :password_resets

end

