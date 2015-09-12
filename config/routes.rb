Rails.application.routes.draw do
  root 'posts#index' 

  resources :posts
  resources :comments, only: :create
end
