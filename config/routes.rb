Rails.application.routes.draw do

  get 'user/create'

  root 'static_pages#home'

  get 'static_pages/home'
  get 'static_pages/greeting'

end

