# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'users#index'
  get 'users/:id', to: 'users#show', as: :user
  get 'users', to: 'users#index', as: :users
  get "users/:user_id/posts", to: "posts#index", as: :user_posts
  get "users/:user_id/posts/:id", to: "posts#show", as: :user_post
  get "users/:user_id/posts/new", to: "posts#new", as: :new_user_post
   

  get 'up' => 'rails/health#show', as: :rails_health_check

  
  
  resources :users, only: [:index , :show]
  resources :posts, only: [:index , :show]

  # Defines the root path route ("/")
  # root "posts#index"
end
