Rails.application.routes.draw do
  resources :home
  root to: 'home#index'
  devise_for :usuarios, controllers: { sessions: "usuarios/sessions" }
end
