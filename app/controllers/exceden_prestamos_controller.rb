class ExcedenPrestamosController < ApplicationController
  before_action :authenticate_usuario!
  load_and_authorize_resource class: :ExcedenPrestamos

  def index
    render template: "exceden_prestamos/index",  layout: 'layouts/application'
  end
end
