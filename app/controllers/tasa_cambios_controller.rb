class TasaCambiosController < ApplicationController
  include Controleable
  before_action :authenticate_usuario!
  before_action :coleccion_inicial, only: %i[index excel_index]

  def coleccion_inicial
    params[:q] ||= {}
    @coleccion = TasaCambio.ransack(params[:q])
    @coleccion.sorts = ["fecha asc"] if @coleccion.sorts.empty?
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
    authorize!(:read, :TasaCambio)
    @params_permit = params[:q].present? ? {q: params[:q] .permit! } : {}
    render template: "tasa_cambios/index",  layout: "layouts/application"
  end

  def new
    authorize!(:create, :TasaCambio)
    render template: "tasa_cambios/form", layout: "layouts/application"
  end

  def show
    authorize!(:update, :TasaCambio)
    render template: "tasa_cambios/form", layout: "layouts/application"
  end

  def edit
    authorize!(:update, :TasaCambio)
    render template: "tasa_cambios/form", layout: "layouts/application"
  end

  def excel_index
    respond_to do |formato|
      formato.xlsx do
        render(
          xlsx: "excel_index",
          filename: "Tasas de cambios del sistema - #{Date.today}.xlsx"
        )
      end
    end
  end

  def create
    begin
      raise if flash.now[:error].present?
      if @registro.save!
        flash[:notice] = "El registro fue guardado exitosamente"
        redirect_to action: :index
      end
    rescue StandardError => e
      flash[:error] = "Ocurrio un error al guardar los datos" if flash.now[:error].blank?
      render template: "tasa_cambios/form", layout: "layouts/application"
    end
  end

  def update
    begin
      raise if flash.now[:error].present?
      if @registro.save!
        flash[:notice] = "El registro fue actualizado exitosamente"
        redirect_to action: :index
      end
    rescue StandardError => e
      flash[:error] = "Ocurrio un error al actualizar los datos" if flash.now[:error].blank?
      render template: "tasa_cambios/form", layout: "layouts/application"
    end
  end

  def destroy
    authorize!(:destroy, :TasaCambio)
    begin
      flash[:notice] = "El registro ha sido eliminado exitosamente" if @registro.destroy
    rescue StandardError => e
      flash[:error] = e.message
    end

    redirect_to action: :index, search: params[:q]
  end

  def bcn_webservice
    begin
      TasaCambio.consumir_webservice_bcn(params[:mes])
      render json: { mensaje: "Se crearon las tasas de cambios exitosamente."}, status: Rack::Utils::SYMBOL_TO_STATUS_CODE[:ok]
    rescue StandardError => e
      render json: { mensaje: "Hubo un error al comunicarse con el servicio web del BCN."}, status: Rack::Utils::SYMBOL_TO_STATUS_CODE[:internal_server_error]
    end
  end

  private

    def nombre_recurso
      "TasaCambio"
    end

    def tasacambio_params
      params.require(:tasacambio).permit(:id, :tasa_cambio, :fecha)
    end

    alias :params_permit :tasacambio_params
end
