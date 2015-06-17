Rails.application.routes.draw do
  root "sessions#new"

  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  resources :users
  resources :sessions
end
