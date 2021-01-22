Rails.application.routes.draw do
  devise_for :usuarios, controllers: { sessions: "usuarios/sessions" }

  resources :informacion_general
  resources :graficos
  resources :pagare
  resources :comprobante
  resources :socios
  resources :cargos
  resources :roles
  resources :tasa_cambio
  resources :empresa
  resources :bancos
  resources :exceden_prestamos
  resources :clientes_nuevos
  resources :clientes_cuotas_vencidas
  resources :clientes_morosos
  resources :formas_pagos
  resources :valor_leche

  root to: 'informacion_general#index'
end
