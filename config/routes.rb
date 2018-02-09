Rails.application.routes.draw do
  root 'home_pages#home'

  # home
  get '/contact', to: 'home_pages#contact'
  get '/about', to: 'home_pages#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
