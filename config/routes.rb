Rails.application.routes.draw do
  root 'home#index'
  resources :tasks
  devise_for :users
  get '/users/:id', to: 'users#dashboard'
end
