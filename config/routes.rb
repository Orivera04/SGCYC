Rails.application.routes.draw do
  devise_for :usuarios, controllers: { sessions: "usuarios/sessions" }

  resources :home
  resources :informacion_general
  resources :graficos
  resources :pagare
  resources :comprobante
  resources :socios

  resources :cargos do
    get :excel_index, on: :collection, defaults: { :format => 'xlsx' }
  end

  resources :roles do
    get :excel_index, on: :collection, defaults: { :format => 'xlsx' }
  end

  resources :tasa_cambio
  resources :empresa

  resources :bancos do
    get :excel_index, on: :collection, defaults: { :format => 'xlsx' }
  end

  resources :exceden_prestamos
  resources :clientes_nuevos
  resources :clientes_cuotas_vencidas
  resources :clientes_morosos
  resources :formas_pagos

  resources :valor_leches do
    get :excel_index, on: :collection, defaults: { :format => 'xlsx' }
  end

  root to: 'home#index'
end
