Rails.application.routes.draw do
  #resources :socios
  get '/socios', to: 'socios#index'
  get '/socios/new', to: 'socios#new'
  post '/socios', to: 'socios#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
