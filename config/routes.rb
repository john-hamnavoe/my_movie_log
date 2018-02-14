Rails.application.routes.draw do
  root 'home_pages#home'

  # home
  get '/contact', to: 'home_pages#contact'
  get '/about', to: 'home_pages#about'
  get '/signup', to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'  
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :movies,              except: [:destroy]
  resources :tmdb_movies,         only: [:index, :show]
end
