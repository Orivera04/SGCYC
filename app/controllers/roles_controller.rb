class RolesController < ApplicationController
  @recurso = :Rol
  include Controleable
  before_action :coleccion_inicial, only: %i[index excel_index]

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

end
