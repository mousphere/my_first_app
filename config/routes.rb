# frozen_string_literal: true

Rails.application.routes.draw do
  get 'likes/create'

  get 'likes/destroy'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  root 'static_pages#home'

  resources :users do
    get 'deactivate', on: :member
    member do
      get :stocks
    end
  end

  resources :articles, param: :genre
  resources :stocks, only: %i[create destroy]
  resources :likes, only: %i[create destroy]
end
