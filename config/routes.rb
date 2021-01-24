Rails.application.routes.draw do

  get '/tcambio', to: 'tasa_cambios#index'
  get '/tcambio/new', to: 'tasa_cambios#new', as: 'new_tasa_cambio'
  post '/tcambio', to: 'tasa_cambios#create'

  get 'tcambio/:id', to: 'tasa_cambios#show', as: 'tasa_cambio'
  get 'tcambio/:id/edit', to: 'tasa_cambios#edit', as: 'edit_tasa'
  patch 'tcambio/:id', to: 'tasa_cambios#update'
  put 'tcambio/:id', to: 'tasa_cambios#update'

  delete 'tcambio/:id', to: 'tasa_cambios#delete'

  get '/tcambio/respuesta', to:'tasa_cambios#new'

  resources :tasa_cambios, except: [:edit, :update, :destroy, :delete] do
    collection do
      match 'search' => 'tasa_cambios#search', via: [ :post], as: :search
    end
  end

  #get '/tcambio/masivo', to: 'tasa_cambios#masivo', as: 'tasa_masivo'

  #resources :tasa_cambios
  resources :home
  root to: 'home#index'

  devise_for :usuarios, controllers: { sessions: "usuarios/sessions" }

  resources :comprobante

end
