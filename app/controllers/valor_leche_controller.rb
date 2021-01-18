class ValorLecheController < ApplicationController
  before_action :authenticate_usuario!
  load_and_authorize_resource class: :ValorLeche

  def index
    render template: "valor_leche/index",  layout: 'layouts/application'
  end
end
