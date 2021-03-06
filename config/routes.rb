# == Route Map
#

Rails.application.routes.draw do
  root to: 'posts#index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth',
                                    registrations: 'users/registrations' }
  resources :users, only: [:index, :show]
  resources :posts, only: [:index, :new, :create, :destroy] do
    resources :likes, only: [:index, :create, :destroy]
    resources :comments, only: [:index, :create, :destroy]
  end
  resources :friend_requests, only: [:create, :destroy]
  resources :friendships, only: [:index, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
