class CargosController < ApplicationController
  before_action :authenticate_usuario!
  load_and_authorize_resource class: :Cargos

  def index
    render template: "cargos/index",  layout: 'layouts/application'
  end
end
