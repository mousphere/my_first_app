# frozen_string_literal: true

Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  root 'static_pages#home'
  post '/', to: 'static_pages#home'

  resources :users do
    member do
      get :notify
      get :stocks
      get :deactivate
      get :followings
      get :followers
      get :followings_articles
    end
  end

  resources :articles do
    resources :comments
  end

  resources :relationships, only: %i[create destroy]
  resources :stocks, only: %i[create destroy]
  resources :likes, only: %i[create destroy]
end
