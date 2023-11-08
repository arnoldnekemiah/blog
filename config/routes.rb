Rails.application.routes.draw do
  root "users#index"
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:create, :destroy]
      member do
        patch 'like', to: 'posts#like'
        patch 'unlike', to: 'posts#unlike'
      end
    end
  end
  
end
