Rails.application.routes.draw do

  get '/tcambio', to: 'tasa_cambios#index'
  get '/tcambio/new', to: 'tasa_cambios#new'
  post '/tcambio', to: 'tasa_cambios#create'

  get 'tcambio/:id', to: 'tasa_cambios#show', as: 'tasa_cambio'
  get 'tcambio/:id/edit', to: 'tasa_cambios#edit', as: 'edit_tasa'
  patch 'tcambio/:id', to: 'tasa_cambios#update'
  put 'tcambio/:id', to: 'tasa_cambios#update'

  delete 'tcambio/:id', to: 'tasa_cambios#delete'

  resources :tasa_cambios, except: [:edit, :update, :destroy, :delete] do
    collection do
      match 'search' => 'tasa_cambios#search', via: [ :post], as: :search
    end
  end

  #resources :tasa_cambios
  resources :home
  root to: 'home#index'

  devise_for :usuarios, controllers: { sessions: "usuarios/sessions" }

  resources :comprobante

end
