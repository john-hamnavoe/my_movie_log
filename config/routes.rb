Rails.application.routes.draw do
  get 'subscription_payment_watches/index'

  root 'home_pages#home'

  # home
  get '/contact', to: 'home_pages#contact'
  get '/about', to: 'home_pages#about'
  get '/privacy', to: 'home_pages#privacy'  
  get '/signup', to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  # resources 
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets,     only: [:new, :create, :edit, :update]
  resources :movies,              except: [:destroy] do
    member do
      patch :release, to: 'movies#release'
    end
  end
  resources :tv_shows,              except: [:destroy, :create, :new]
  resources :movie_interests,      only: [:create, :destroy]
  post '/create_from_tmdb',       to: 'movies#create_from_tmdb'
  post '/create_tv_from_tmdb',       to: 'tv_shows#create_from_tmdb'
  resources :tmdb_movies,         only: [:index, :show]
  resources :tmdb_tv_shows,       only: [:index, :show]  
  resources :subscriptions,       except: [:destroy]  do
    resources :watches, only: [:index], to: 'subscription_watches#index'
  end
  resources :locations,           except: [:destroy, :show]
  resources :subscription_payments, only: [:edit, :update]  do
    resources :watches, only: [:index], to: 'subscription_payment_watches#index'
  end
  resources :watches do
    get :friends, to: 'watches#friends'   
  end
  resources :watch_likes,         only: [:create, :destroy]
  delete 'friends/destroy'
  resources :friend_requests
  get '/friend_feed', to: 'friend_watches#index'
  
  # charts
  namespace :charts do 
    namespace :users do 
      namespace :watches do 
        get 'watch'
        get 'location_cinema'
        get 'rating'
      end
      namespace :subscriptions do
        get 'watch'
      end
    end
    namespace :application do
      namespace :movies do
      end
    end
  end
  
  # upcoming movies
  get 'upcoming_movies', to: 'upcoming_movies#index'
end
