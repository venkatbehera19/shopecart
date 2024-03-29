Rails.application.routes.draw do
  get '/login',             to: 'sessions#new'
  post '/login',            to: 'sessions#create'
  delete '/logout',         to: 'sessions#destroy'
  delete '/delete_product', to: 'products#delete_product'
  get 'static_pages/home'
  get 'signup_seller' ,     to: 'users#new_seller'
  post 'signup_seller' ,    to: 'users#create_new_seller'

  get 'checkout', to: 'checkout#show'
  get 'checkout/success', to: 'checkout#success'
  get 'billing', to: 'billing#show'
  
  root "static_pages#home"
  resources :products
  resources :users 
  resources :cart_items
  resources :orders do 
    resources :order_items 
  end
  resources :categories
  resources :roles
end
