# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root 'users#index'

  # Defines the routes for the application
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:create, :new, :destroy]
      resources :likes, only: [:create, :new]
    end
  end

  namespace :api, defaults: { format: :json } do
    resources :users, only: [:index] do
      resources :posts, only: [:index] do
        resources :comments, only: [:index, :create]
      end
    end
  end
  
  get 'up' => 'rails/health#show', as: :rails_health_check

end
