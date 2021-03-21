class RolesController < ApplicationController
  @recurso = :Rol
  include Controleable
  before_action :coleccion_inicial, only: %i[index excel_index]
  prepend_before_action :procesar_parametros, only: %i[create update]

  def coleccion_inicial
    params[:q] ||= {}
    @coleccion = Rol.ransack(params[:q])
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
    authorize!(:index, :Rol)
    @params_permit = params[:q].present? ? {q: params[:q] .permit! } : {}
    render template: "roles/index",  layout: 'layouts/application'
  end

  def new
    authorize!(:new, :Rol)
    render template: 'roles/form', layout: 'layouts/application'
  end

  def edit
    authorize!(:edit, :Rol)
    render template: 'roles/form', layout: 'layouts/application'
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
      render template: "roles/form", layout: "layouts/application"
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
      render template: "roles/form", layout: "layouts/application"
    end
  end

  def destroy
    authorize!(:destroy, :Rol)
    begin
      flash[:notice] = "El registro ha sido eliminado exitosamente" if @registro.destroy
    rescue StandardError => e
      flash[:error] = e.message
    end

    redirect_to action: :index, search: params[:q]
  end

  def excel_index
    respond_to do |formato|
      formato.xlsx do
        render(
          xlsx: "excel_index",
          filename: "Roles del sistema - #{Date.today}.xlsx"
        )
      end
    end
  end

  private

    def nombre_recurso
      "Rol"
    end

    def rol_params
      params.require(:rols)
             .permit(:id, :nombre,
                     rol_accion_attributes: [:id, :rol_id, :recurso_id, :accion_id])
    end

    def procesar_parametros
      params[:rols][:rol_accion_attributes] = []
      recursos_roles = params[:permisos] || []

      recursos_roles.each  do |recurso|
        binding.pry
        llaves_recurso = recurso.first.split("_")
        params[:rols][:rol_accion_attributes].push(id: llaves_recurso[Rol::ID] ,rol_id: llaves_recurso[Rol::ROL_ID],
              recurso_id: llaves_recurso[Rol::RECURSO_ID], accion_id: llaves_recurso[Rol::ACCION_ID])
      end
    end

    alias :params_permit :rol_params
end
