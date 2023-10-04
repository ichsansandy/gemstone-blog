# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  root "users#index"

  get "/users/:id/profile", to: "users#show", as: "user"
  get "/users", to: "users#index", as: "users"
  
  post "/users/:user_id/posts/:id/newcomment", to: "comments#create", as: "create_new_comment"
  post "/users/:user_id/posts/:id/newlike", to: "likes#create", as: "create_new_like"
  get "/users/:user_id/posts/new", to: "posts#new", as: "user_new_posts"
  post "/users/:user_id/posts/new", to: "posts#create", as: "create_user_posts"
  get "/users/:user_id/posts/:id", to: "posts#show", as: "user_post"
  get "/users/:user_id/posts", to: "posts#index", as: "user_posts"

  get '/sign_out_user', to: 'users#sign_out_user', as: 'sign_out_user'

  delete "/users/:user_id/posts/:post_id/comments/:id", to: "comments#destroy", as: "delete_comment"
  delete "/users/:user_id/posts/:id", to: "posts#destroy", as: "delete_post"

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :users, only: [] do
        resources :posts, only: [:index] do
          resources :comments, only: [:index, :create]
        end
      end
    end
  end
end
