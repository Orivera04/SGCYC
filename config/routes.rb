Rails.application.routes.draw do
  devise_for :usuarios, controllers: { sessions: "usuarios/sessions" }, path_prefix: "auth"

  resources :home
  resources :informacion_general
  resources :graficos

  resources :pagares do
    get :excel_index, on: :collection, defaults: { :format => "xlsx" }
    get :pagare_odt, on: :collection, defaults: { :format => "odt" }
    get :calendario_pdf, on: :collection, defaults: { :format => "pdf" }
  end

  resources :comprobantes

  resources :socios do
    get :excel_index, on: :collection, defaults: { :format => "xlsx" }
  end

  resources :cargos do
    get :excel_index, on: :collection, defaults: { :format => "xlsx" }
  end

  resources :roles do
    get :excel_index, on: :collection, defaults: { :format => "xlsx" }
  end

  resources :tasa_cambios do
    get :excel_index, on: :collection, defaults: { :format => "xlsx" }
  end
  match 'tasa_cambios/bcn_webservice' => 'tasa_cambios#bcn_webservice', via: :post

  resources :empresa

  resources :bancos do
    get :excel_index, on: :collection, defaults: { :format => "xlsx" }
  end

  resources :exceden_prestamos
  resources :clientes_nuevos
  resources :clientes_cuotas_vencidas
  resources :clientes_morosos

  resources :formas_pagos do
    get :excel_index, on: :collection, defaults: { :format => "xlsx" }
  end

  resources :valor_leches do
    get :excel_index, on: :collection, defaults: { :format => "xlsx" }
  end

  resources :usuarios do
    get :excel_index, on: :collection, defaults: { :format => "xlsx" }
  end

  match 'tasa_cambio_leche' => 'valor_leches#crear_tasa_cambio_diaria', via: :post
  root to: "home#index"
end
