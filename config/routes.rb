Rails.application.routes.draw do

  namespace :api, defaults:  { format: :json } do

    # SESSIONS API
    resource :sessions, only: [:create, :destroy]
    post '/login', to: 'sessions#create'
    post '/logout', to: 'sessions#destroy'
    post '/signup', to: 'sessions#signup'

    # USERS API
    resource :users, only: [:update, :show, :destroy]
    get '/user/profile', to: 'users#show'
    get '/user/verify', to: 'users#verify'

    # POSTS API
    resources :posts, only: [:create, :show, :update, :destroy, :index]
    get '/user/posts', to: 'posts#posts_by_user'
    get '/posts/:id/responses', to: 'posts#post_responses'

  end
end
