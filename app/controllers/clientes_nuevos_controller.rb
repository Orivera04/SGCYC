class ClientesNuevosController < ApplicationController
  before_action :authenticate_usuario!
  before_action :coleccion_inicial, only: %i[index excel_index]

  def coleccion_inicial
    params[:q] ||= {}
    return unless params[:commit].present?
    @coleccion = Socio.ransack(params[:q])
    respond_to do |formato|
      formato.html do
        @registros = @coleccion.result.page(params[:page])
      end
      formato.xlsx do
        @registros = @coleccion.result
      end
    end
  end

  def index
    authorize!(:read, :ClientesNuevos)
    @params_permit = params[:commit].present? ? {q: params[:q].permit! } : {}
    if params[:commit].present?
      render template: "clientes_nuevos/informe",  layout: 'layouts/application'
    else
      render template: "clientes_nuevos/panel",  layout: 'layouts/application'
    end
  end
end
