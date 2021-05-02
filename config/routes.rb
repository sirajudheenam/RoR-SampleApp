Rails.application.routes.draw do

  resources :users
  get 'home/index'
  get 'home/info'
  get 'home/contact'
  get 'home/about'
  get 'home/validation'
  resources :sharks do
    resources :posts
  end
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end