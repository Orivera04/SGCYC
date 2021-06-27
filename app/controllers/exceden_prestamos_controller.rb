class ExcedenPrestamosController < ApplicationController
  before_action :authenticate_usuario!
  before_action :coleccion_inicial, only: %i[index excel_index]

  def coleccion_inicial
    params[:q] ||= {}
    return unless params[:commit].present?
    @coleccion = Pagare.select("count(*) AS conteo, socio_id").group(:socio_id).having("count(*) > #{params[:q][:numero_prestamos]}")
    respond_to do |formato|
      formato.html do
        @registros = @coleccion
      end
      formato.xlsx do
        @registros = @coleccion
      end
    end
  end

  def index
    authorize!(:read, :ExcedenPrestamos)
    @params_permit = params[:commit].present? ? {q: params[:q].permit! } : {}
    if params[:commit].present?
      render template: "exceden_prestamos/informe",  layout: 'layouts/application'
    else
      render template: "exceden_prestamos/panel",  layout: 'layouts/application'
    end
  end
end