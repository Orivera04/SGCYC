class ValorLechesController < ApplicationController
  include Controleable
  before_action :authenticate_usuario!
  before_action :coleccion_inicial, only: %i[index excel_index]

  def coleccion_inicial
    params[:q] ||= {}
    @coleccion = ValorLeche.ransack(params[:q])
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
    binding.pry
    authorize!(:read, :ValorLeche)
    @params_permit = params[:q].present? ? {q: params[:q] .permit! } : {}
    render template: "valor_leches/index",  layout: "layouts/application"
  end

  def new
    authorize!(:create, :ValorLeche)
    render template: "valor_leches/form", layout: "layouts/application"
  end

  def show
    authorize!(:update, :ValorLeche)
    render template: "valor_leches/form", layout: "layouts/application"
  end

  def edit
    authorize!(:update, :ValorLeche)
    render template: "valor_leches/form", layout: "layouts/application"
  end

  def excel_index
    respond_to do |formato|
      formato.xlsx do
        render(
          xlsx: "excel_index",
          filename: "Valores de la leche del sistema - #{Date.today}.xlsx"
        )
      end
    end
  end

  def create
    begin
      if @registro.save!
        flash[:notice] = "El registro fue guardado exitosamente"
        redirect_to action: :index
      end
    rescue StandardError => e
      flash[:error] = "Ocurrio un error al guardar los datos" if flash.now[:error].blank?
      render template: "valor_leches/form", layout: "layouts/application"
    end
  end

  def update
    begin
      if @registro.save!
        flash[:notice] = "El registro fue actualizado exitosamente"
        redirect_to action: :index
      end
    rescue StandardError => e
      flash[:error] = "Ocurrio un error al actualizar los datos" if flash.now[:error].blank?
      render template: "valor_leches/form", layout: "layouts/application"
    end
  end

  def destroy
    authorize!(:destroy, :ValorLeche)
    begin
      flash[:notice] = "El registro ha sido eliminado exitosamente" if @registro.destroy
    rescue StandardError => e
      flash[:error] = e.message
    end

    redirect_to action: :index, search: params[:q]
  end

  def crear_tasa_cambio_diaria
    begin
      ValorLeche.new(tasa_cambio: params[:tasa_cambio], fecha: Date.today).save!
      render json: { mensaje: "Se creo el valor para el dia de hoy exitosamente."}, status: Rack::Utils::SYMBOL_TO_STATUS_CODE[:ok]
    rescue StandardError => e
      render json: { mensaje: "Hubo un error al comunicarse con el servicio web del BCN."}, status: Rack::Utils::SYMBOL_TO_STATUS_CODE[:internal_server_error]
    end
  end

  private

    def nombre_recurso
      "ValorLeche"
    end

    def valorleche_params
      params.require(:valor_leches).permit(:id, :tasa_cambio, :fecha)
    end

    alias :params_permit :valorleche_params
end
