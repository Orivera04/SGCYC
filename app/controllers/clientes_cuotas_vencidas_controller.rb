class ClientesCuotasVencidasController < ApplicationController
  before_action :authenticate_usuario!
  before_action :coleccion_inicial, only: %i[index excel_index]

  def coleccion_inicial
    params[:q] ||= {}
    params[:q][:fecha_pago_lt] = Date.today
    params[:q][:cancelado_eq] = false
    @coleccion = Cuota.ransack(params[:q])
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
    authorize!(:read, :ClientesCuotasVencidas)
    render template: "clientes_cuotas_vencidas/informe",  layout: 'layouts/application'
  end
end
