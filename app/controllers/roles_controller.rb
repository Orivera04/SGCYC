class RolesController < ApplicationController
  before_action :authenticate_usuario!
  before_action :coleccion_inicial, only: :index
  load_and_authorize_resource class: :Roles

  def coleccion_inicial
    params[:q] ||= {}
    @coleccion = Rol.ransack(params[:q])
    respond_to do |formato|
      formato.html do
        @registros = @coleccion.result.page(params[:page])
      end
    end
  end

  def index
    render template: "roles/index",  layout: 'layouts/application'
  end

end
