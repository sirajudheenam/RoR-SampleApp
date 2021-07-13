Rails.application.routes.draw do

  resources :instruments
  get '/info', to: 'instruments#info'

  root   'static_pages#home'
  get    '/help',    to: 'static_pages#help'
  get    '/about',   to: 'static_pages#about'
  get    '/contact', to: 'static_pages#contact'
  get    '/signup',  to: 'users#new'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :microposts,          only: [:create, :destroy]
  resources :relationships,       only: [:create, :destroy]

  resources :profiles
  match '/validation', to: 'static_pages#validation', via: :get

  resources :sharks do
    resources :posts
  end

  post '/login', to: 'users#show'
  post 'rails/active_storage/direct_uploads', to: 'direct_uploads#create'
#  root 'static_pages#home'


# resources :authors
# resources :articles
# resources :magazines
# resources :publishers

# Nested Routes: # Never complicate like this
  resources :publishers do
    resources :magazines do
      resources :articles do
        resources :comments
      end
    end
  end   


  # Use this instead.
  # map.resources :publishers do |publishers|
  #   publishers.resources :magazines, :name_prefix => "publisher_"
  # end
  
  # map.resources :magazines do |magazines|
  #   magazines.resources :articles, :name_prefix => "magazine_"
  # end
  
  # map.resources :articles do |articles|
  #   articles.resources :comments, :name_prefix => "article_"
  # end
  
  # map.resources :comments
  
  # The above will produce this
  # publishers_url              #-> /publishers
  # publisher_url(1)            #-> /publishers/1
  # publisher_magazine_url(1)   #-> /publishers/1/magazine
  # magazine_url(2)             #-> /magazines/2
  # magazine_articles_url(2)    #-> /magazines/2/articles
  # article_url(3)              #-> /articles/3
  # article_comments_url(3)     #-> /articles/3/comments
  # comment_url(4)              #-> /comments/4

end
