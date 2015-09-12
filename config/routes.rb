Rails.application.routes.draw do
  root 'posts#index' 

  resources :posts do
    resources :comments, only: [:create, :edit, :destroy]
  end
end
