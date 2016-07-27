Rails.application.routes.draw do
  root 'topics#index'

  #get 'users/new'
  get   '/signup',  to: 'users#new'
  post  '/signup',  to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to:'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  #get 'users/show'
  resources :users

  resources :topics do
    #get "showComments"
    resources :conversations do
      get "show_posts_link"
      resources :posts
      get "getPosts"
    end
  end

  resources :account_activations, only: [:edit]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
