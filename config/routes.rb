Rails.application.routes.draw do
  resources :sharks do
    resources :posts
  end
  root 'sharks#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end