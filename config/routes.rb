Rails.application.routes.draw do
  devise_for :admins
  root 'posts#index' 

  resources :posts do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end
end
