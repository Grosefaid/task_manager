Rails.application.routes.draw do
  root 'home#index'
  resources :tasks do
    member do
      get 'start'
      get 'finish'
    end
  end
  devise_for :users
  get '/users/:id', to: 'users#dashboard'
end
