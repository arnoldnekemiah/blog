Rails.application.routes.draw do
  root "users#index"
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do
      member do
        get 'new_comment', to: 'comments#new'
        post 'create_comment', to: 'comments#create'
      end
      resources :likes, only: [:create, :destroy]
    end
  end
  resources :comments, only: [:new, :create]
end