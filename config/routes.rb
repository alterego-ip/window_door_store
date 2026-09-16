Rails.application.routes.draw do
  devise_for :users

  root "products#index"

  resources :products, only: [:index, :show]

  resource :configurator, only: [:show, :create] do
    post :calculate, on: :collection
  end

  namespace :admin do
    resources :products
  end
end