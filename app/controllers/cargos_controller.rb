class CargosController < ApplicationController
  include Controleable
  before_action :authenticate_usuario!
  before_action :coleccion_inicial, only: %i[index excel_index]

  def coleccion_inicial
    params[:q] ||= {}
    @coleccion = Cargo.ransack(params[:q])
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
    authorize!(:read, :Cargos)
    @params_permit = params[:q].present? ? {q: params[:q] .permit! } : {}
    render template: "cargos/index",  layout: "layouts/application"
  end

  def new
    authorize!(:create, :Cargos)
    render template: "cargos/form", layout: "layouts/application"
  end

  def show
    authorize!(:update, :Cargos)
    render template: "cargos/form", layout: "layouts/application"
  end

  def edit
    authorize!(:update, :Cargos)
    render template: "cargos/form", layout: "layouts/application"
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
      raise if flash.now[:error].present?
      if @registro.save!
        flash[:notice] = "El registro fue guardado exitosamente"
        redirect_to action: :index
      end
    rescue StandardError => e
      flash[:error] = "Ocurrio un error al guardar los datos" if flash.now[:error].blank?
      render template: "cargos/form", layout: "layouts/application"
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
      render template: "cargos/form", layout: "layouts/application"
    end
  end

  def destroy
    authorize!(:destroy, :Cargos)
    begin
      flash[:notice] = "El registro ha sido eliminado exitosamente" if @registro.destroy
    rescue StandardError => e
      flash[:error] = e.message
    end

    redirect_to action: :index, search: params[:q]
  end

  private

    def nombre_recurso
      "Cargo"
    end

    def cargos_params
      params.require(:cargos).permit(:id, :nombre, :descripcion)
    end

    alias :params_permit :cargos_params
end
