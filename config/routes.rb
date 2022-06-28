Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#new"
  root "rails#index"

  resource :users, only: [:update, :show, :destroy]
  resource :sessions, only: [:create, :destroy, :singup]

  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
  post '/singup', to: 'sessions#singup'
  get '/user/profile', to: 'users#show'
end
