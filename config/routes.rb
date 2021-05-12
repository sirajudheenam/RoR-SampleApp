Rails.application.routes.draw do


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

end
