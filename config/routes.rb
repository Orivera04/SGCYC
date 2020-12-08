Rails.application.routes.draw do
  devise_for :usuarios

  # Rutas de la aplicación
  resource :logins, default: {action: :index }
end
