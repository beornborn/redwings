Rails.application.routes.draw do

  root :to => 'static_pages#home'

  get 'user_sessions/new'
  get 'user_sessions/create'
  get 'user_sessions/destroy'

  get 'static_pages/home'
  get 'static_pages/greeting'

  get  'greeting' => 'static_pages#greeting', :as => :greeting
  get  'login'    => 'user_sessions#new',     :as => :login
  post 'logout'   => 'user_sessions#destroy', :as => :logout

  resources :users
  resources :user_sessions

end

