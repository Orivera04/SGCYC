class ClientesMorososController < ApplicationController
  before_action :authenticate_usuario!
  before_action :coleccion_inicial, only: %i[index excel_index]

  def coleccion_inicial
    params[:q] ||= {}
    @coleccion = Cuota.select{|cuota| cuota.calcular_mora > Comprobante::SALDO_CERO}
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
    authorize!(:read, :ClientesMorosos)
    render template: "clientes_morosos/informe",  layout: 'layouts/application'
  end
end
