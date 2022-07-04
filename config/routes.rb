Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#new"
  #root "rails#index"

  resource :users, only: [:update, :show, :destroy]
  resource :sessions, only: [:create, :destroy]

  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
  post '/signup', to: 'sessions#signup'
  get '/user/profile', to: 'users#show'
end
