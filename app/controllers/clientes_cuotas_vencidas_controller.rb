class ClientesCuotasVencidasController < ApplicationController
  before_action :authenticate_usuario!
  load_and_authorize_resource class: :ClientesCuotasVencidas

  def index
    render template: "clientes_cuotas_vencidas/index",  layout: 'layouts/application'
  end
end
