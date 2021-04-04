class PagaresController < ApplicationController
  include Controleable
  before_action :authenticate_usuario!
  before_action :coleccion_inicial, only: %i[index excel_index]

  def coleccion_inicial
    params[:q] ||= {}
    @coleccion = Pagare.ransack(params[:q])
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
    authorize!(:read, :Pagare)
    @params_permit = params[:q].present? ? {q: params[:q] .permit! } : {}
    render template: "pagares/index",  layout: "layouts/application"
  end

  def new
    authorize!(:create, :Pagare)
    render template: "pagares/form", layout: "layouts/application"
  end

  def show
    authorize!(:update, :Pagare)
    render template: "pagares/form", layout: "layouts/application"
  end

  def edit
    authorize!(:update, :Pagare)
    render template: "pagares/form", layout: "layouts/application"
  end

  def excel_index
    respond_to do |formato|
      formato.xlsx do
        render(
          xlsx: "excel_index",
          filename: "Cargos del sistema - #{Date.today}.xlsx"
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
      render template: "pagares/form", layout: "layouts/application"
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
      render template: "pagares/form", layout: "layouts/application"
    end
  end

  def destroy
    authorize!(:destroy, :Pagare)
    begin
      flash[:notice] = "El registro ha sido eliminado exitosamente" if @registro.destroy
    rescue StandardError => e
      flash[:error] = e.message
    end

    redirect_to action: :index, search: params[:q]
  end

  private

    def nombre_recurso
      "Pagare"
    end

    def pagare_params
      params.require(:pagare).permit(:id, :nombre, :descripcion)
    end

    alias :params_permit :pagare_params
end
