Rails.application.routes.draw do
  devise_for :users

  root "products#index"

  resources :products, only: [:index, :show]

  resource :configurator, only: [:show, :create] do
    post :calculate, on: :collection
  end

  resource :cart, only: [:show, :destroy]
  resources :cart_items, only: [:create, :update, :destroy]
  
  resources :orders, only: [:index, :new, :create, :show]

  namespace :admin do
    resources :products
    resources :orders, only: [:index, :show, :update]
  end
end