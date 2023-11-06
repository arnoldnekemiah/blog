Rails.application.routes.draw do
  root "users#index"
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:create, :destroy]
      post 'like', to: 'posts#like', on: :member  # Define the like route as POST on a member
    end
  end
  
  
end


