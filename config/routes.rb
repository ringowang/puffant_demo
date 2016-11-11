Rails.application.routes.draw do
  root 'users#index'
  get 'sessions/new'

#  resources :users
  resources :users do
    resources :meetups
  end

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
