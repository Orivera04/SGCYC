class TasaCambioController < ApplicationController
  before_action :authenticate_usuario!
  load_and_authorize_resource class: :TasaCambio

  def index
    render template: "tasa_cambio/index",  layout: 'layouts/application'
  end
end
