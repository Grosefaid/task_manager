Rails.application.routes.draw do
  root 'home#index'
  resources :tasks
  devise_for :users
end
