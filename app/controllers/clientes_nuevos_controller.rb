class ClientesNuevosController < ApplicationController
  before_action :authenticate_usuario!
  load_and_authorize_resource class: :ClientesNuevos

  def index
    render template: "clientes_nuevos/index",  layout: 'layouts/application'
  end
end
