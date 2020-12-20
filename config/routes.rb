Rails.application.routes.draw do
  resources :contents
  resources :articles
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/sign_in', to: 'session#index_sign_in'
  post '/sign_in', to: 'session#sign_in'
  delete '/sign_out', to: 'session#sign_out'
  
  get '/articles/contents/:id', to: 'contents#show', as: 'content_show'
  get '/points', to: "users#points"
  
  #articles$
  # get '/articles', to: 'articles#index'
  # get 'arctiles/new', to: 'articles#new'
  # post '/articles', to: 'articles#create'

  get  '/articles/comments/new/:id', to: 'articles#new_comment', as: 'new_comment'
  post '/articles/comments', to: 'articles#create_comment'
  get  '/articles/comments', to: 'articles#index_comment', as: 'comments'
end