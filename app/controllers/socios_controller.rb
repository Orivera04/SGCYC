class SociosController < ApplicationController
  include Controleable
  before_action :authenticate_usuario!
  before_action :coleccion_inicial, only: %i[index excel_index]

  def coleccion_inicial
    params[:q] ||= {}
    @coleccion = Socio.ransack(params[:q])
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
    authorize!(:read, :Socios)
    @params_permit = params[:q].present? ? {q: params[:q].permit! } : {}
    render template: "socios/index",  layout: "layouts/application"
  end

  def new
    authorize!(:create, :Socios)
    render template: "socios/form", layout: "layouts/application"
  end

  def show
    authorize!(:update, :Socios)
    render template: "socios/form", layout: "layouts/application"
  end

  def edit
    authorize!(:update, :Socios)
    render template: "socios/form", layout: "layouts/application"
  end

  def excel_index
    respond_to do |formato|
      formato.xlsx do
        render(
          xlsx: "excel_index",
          filename: "Socios del sistema - #{Date.today}.xlsx"
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
      render template: "socios/form", layout: "layouts/application"
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
      render template: "socios/form", layout: "layouts/application"
    end
  end

  def destroy
    authorize!(:destroy, :Socios)
    begin
      flash[:notice] = "El registro ha sido eliminado exitosamente" if @registro.destroy
    rescue StandardError => e
      flash[:error] = e.message
    end

    redirect_to action: :index, search: params[:q]
  end

  private

    def nombre_recurso
      "Socio"
    end

    def socios_params
      params.require(:socios)
            .permit(:id, :codigo_socio, :nombre, :apellido, :numero_cedula, :fecha_nacimiento,
                    :sexo_id, :escolaridad_id, :profesion, :estado_civil_id, :anios_relacion,
                    :numero_dependiente, :tipo_domicilio_id, :numero_telefono, :direccion_domiciliar,
                    :departamento, :municipio, :nombre_conyuge, :apellido_conyuge, :numero_cedula_conyuge,
                    :fecha_nacimiento_conyuge, :sexo_id_conyuge, :ocupacion_conyuge, :telefono_conyuge,
                    :lugar_trabajo_conyuge, :tiempo_laborar_conyuge, :direccion_domicilio_conyuge,
                    :empresa, :numero_inss, :direccion_empresa, :departamento_empresa, :municipio_empresa,
                    :numero_telefono_empresa, :tiempo_laborar, :cargo, :salario_mensual, :forma_pago,
                    fiador_attributes: [:id, :socio_id, :nombre, :numero_cedula, :municipio, :nombre_conyuge, :lugar_trabajo,
                                        :direccion_domicilio, :egreso_mensual, :tiempo_laborar, :tiempo_conocer_solicitante,
                                        :apellido, :domicilio, :estado_civil_id, :profesion, :telefono, :salario_mensual,
                                        :disponibilidad_al_mes, :anio_parentesco ] )
    end

    alias :params_permit :socios_params
end
