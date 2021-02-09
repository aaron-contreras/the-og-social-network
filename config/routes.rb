# == Route Map
#

Rails.application.routes.draw do
  root to: 'users#index'
  devise_for :users
  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :new, :create, :destroy] do
    resources :likes, only: [:index, :create, :destroy]
    resources :comments, only: [:index, :create, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
