Rails.application.routes.draw do
  root 'users#index'
  get '/users', to: 'users#index'
  get '/users/:id', to: 'users#show', as: 'user'
  get '/users/:user_id/posts', to: 'posts#index', as: 'user_posts'
  get '/users/:user_id/posts/new', to: 'posts#new', as: 'new_user_post'
  get '/users/:user_id/posts/:id', to: 'posts#show', as: 'user_post'
  post '/users/:user_id/posts', to: 'posts#create', as: 'create_user_post'

  # Custom routes for likes
  post '/users/:user_id/posts/:post_id/likes', to: 'likes#create', as: 'post_likes'
  delete '/users/:user_id/posts/:post_id/likes/:id', to: 'likes#destroy', as: 'post_like'

  get '/users/:user_id/posts/:post_id/comments/new', to: 'comments#new', as: 'new_user_post_comment'
  post '/users/:user_id/posts/:post_id/comments', to: 'comments#create', as: 'create_post_comment'
end
