# frozen_string_literal: true

Rails.application.routes.draw do
  root "users#index"

  get "/users/:user_id/posts/:id", to: "posts#show", as: "user_post"
  get "/users/:user_id/posts", to: "posts#index", as: "user_posts"
  get "/users/:id", to: "users#show", as: "user"
  get "/users", to: "users#index", as: "users"
end
