Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :items
  resources :puechases, only: [:index, :new, :create]
end