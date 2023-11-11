Rails.application.routes.draw do
  devise_for :users
  root "users#index"
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:create, :destroy]
      patch 'like', on: :member
      patch 'unlike', on: :member
    end
  end
  resources :comments, only: [:destroy]
end
