Rails.application.routes.draw do
  get '/sessions/new' => 'sessions#index'
  get '/users/new' => 'users#new'
  get '/users/:id' => 'users#show'
  post '/users/create' => 'users#create_user'
  post '/sessions/create' => 'sessions#create'
  post '/users/new' => 'users#create_user'
  delete '/sessions' => 'sessions#delete'
  get '/users/:id/edit' => 'users#edit'
  patch 'users/:id/update' => 'users#update'
  get '/secrets' => 'users#secrets'
  post '/new_secrets/:id' => 'users#new_secret'
  post '/secret/destroy/:id' => 'users#destroy_secret'
  post '/user/destroy/:id' => 'users#destroy'
  post '/likes/:id' => 'users#create_like'
  post '/destroy/:id' => 'users#destroy_like'

end
  