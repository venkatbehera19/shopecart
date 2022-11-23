Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get 'static_pages/home'
  
  root "static_pages#home"
  resources :users , only: [:create, :new]
end
