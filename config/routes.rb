Rails.application.routes.draw do
  root 'home#index' 

  resources :posts
  resources :comments, only: :create
end
