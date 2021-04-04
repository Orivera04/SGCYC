class EmpresaController < ApplicationController
  include Controleable
  before_action :authenticate_usuario!
  before_action :coleccion_inicial, only: %i[index excel_index]

  def coleccion_inicial
    params[:q] ||= {}
    @registros = Empresa.first
  end

  def index
    empresa = Empresa.first
    redirect_to edit_empresa_path(empresa)
  end

  def edit
    authorize!(:update, :Empresa)
    render template: "empresa/form", layout: "layouts/application"
  end

  def show
    empresa = Empresa.first
    redirect_to edit_empresa_path(empresa)
  end

  def update
    begin
      if @registro.save!
        flash[:notice] = "El registro fue actualizado exitosamente"
        redirect_to action: :index
      end
    rescue StandardError => e
      flash[:error] = "Ocurrio un error al actualizar los datos" if flash.now[:error].blank?
      render template: "empresa/form", layout: "layouts/application"
    end
  end

  private

    def nombre_recurso
      "Empresa"
    end

    def empresa_params
      imagen = params[:empresas][:logo_imagen]
      if imagen.present?
        archivo = File.open(imagen).read
        params[:empresas][:logo_imagen] = Base64.encode64(archivo)
      end

      params.require(:empresas).permit(:id, :nombre_comercial, :numero_telefono, :direccion,
                                       :correo, :actividad_comercial, :numero_ruc, :logo_imagen)
    end

    alias :params_permit :empresa_params
end
