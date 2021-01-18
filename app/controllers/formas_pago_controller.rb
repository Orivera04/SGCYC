class FormasPagoController < ApplicationController
  before_action :authenticate_usuario!
  load_and_authorize_resource class: :FormasPago

  def index
    render template: "formas_pago/index",  layout: 'layouts/application'
  end
end
