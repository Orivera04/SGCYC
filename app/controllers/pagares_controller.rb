class PagaresController < ApplicationController
  include Controleable
  before_action :authenticate_usuario!
  before_action :configurar_pagare, only: %i[create]
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
    @params_permit = params.present? ? {q: params.permit! } : {}
    render template: "pagares/form", layout: "layouts/application"
  end

  def excel_index
    respond_to do |formato|
      formato.xlsx do
        render(
          xlsx: "excel_index",
          filename: "Pagares del sistema - #{Date.today}.xlsx"
        )
      end
    end
  end

  def pagare_odt
    pagare = Pagare.find(params[:q][:id])
    reporte = ODFReport::Report.new( Rails.root.join("app", "assets/documents/pagare.odt")) do |odt|
      odt.add_field :socio_numero, pagare.socio.codigo_socio
      odt.add_field :fecha, pagare.socio.created_at.to_date
      odt.add_field :analista, pagare.usuario.nombre
      odt.add_field :nombre, pagare.socio.display_name
      odt.add_field :fecha_socio, pagare.socio.fecha_nacimiento
      odt.add_field :cedula, pagare.socio.numero_cedula
      odt.add_field :edad, Date.today.year - pagare.socio.fecha_nacimiento.year
      odt.add_field :sexo, pagare.socio.sexo.display_name
      odt.add_field :escolaridad, pagare.socio.escolaridad.display_name
      odt.add_field :profesion, pagare.socio.profesion
      odt.add_field :estado_civil, pagare.socio.estado_civil.display_name
      odt.add_field :anio_relacion, pagare.socio.anios_relacion
      odt.add_field :dependientes, pagare.socio.numero_dependiente
      odt.add_field :pertenencia, pagare.socio.tipo_domicilio.display_name
      odt.add_field :telefono, pagare.socio.numero_telefono
      odt.add_field :direccion, pagare.socio.direccion_domiciliar
      odt.add_field :municipio, pagare.socio.municipio
      odt.add_field :departamento, pagare.socio.departamento
      odt.add_field :nombre_conyuge, pagare.socio.display_name_conyuge
      odt.add_field :cedula_conyuge, pagare.socio.numero_cedula_conyuge
      odt.add_field :fecha_conyuge, pagare.socio.fecha_nacimiento_conyuge
      odt.add_field :edad_conyuge, Date.today.year - pagare.socio.fecha_nacimiento_conyuge.year
      odt.add_field :ocupacion_conyuge, pagare.socio.ocupacion_conyuge
      odt.add_field :telefono_conyuge, pagare.socio.telefono_conyuge
      odt.add_field :lugar_trabajo, pagare.socio.lugar_trabajo_conyuge
      odt.add_field :tiempo_laborar_conyuge, pagare.socio.tiempo_laborar_conyuge
      odt.add_field :direccion_conyuge, pagare.socio.direccion_domicilio_conyuge
      odt.add_field :empresa, pagare.socio.empresa
      odt.add_field :inss, pagare.socio.numero_inss
      odt.add_field :direccion_empresa, pagare.socio.direccion_empresa
      odt.add_field :departamento_empresa, pagare.socio.departamento_empresa
      odt.add_field :municipio_empresa, pagare.socio.municipio_empresa
      odt.add_field :telefono_empresa, pagare.socio.numero_telefono_empresa
      odt.add_field :tiempo_laborar_empresa, pagare.socio.tiempo_laborar
      odt.add_field :cargo_empresa, pagare.socio.cargo
      odt.add_field :salario_mensual, pagare.socio.salario_mensual
      odt.add_field :forma_pago_empresa, pagare.socio.forma_pago
      odt.add_field :cantidad_solicitada, pagare.cantidad_solicitada
      odt.add_field :plazo, pagare.plazo.nombre
      odt.add_field :forma_pago, pagare.forma_pago
      odt.add_field :cuota_pagar, pagare.cuota_pagar
      odt.add_field :destino_credito, pagare.destino_credito
      odt.add_field :ubi, pagare.ubicacion_inversion
      odt.add_field :garantias_ofrecidas, pagare.garantias_ofrecidas
      odt.add_field :condiciones_diferentes, I18n.t(pagare.aceptar_condiciones_diferentes)
      odt.add_field :credito, I18n.t(pagare.tuvo_credito)
      odt.add_field :tiene_credito, I18n.t(pagare.tiene_credito_actualmente)
      odt.add_field :institucion_1, pagare.antecedente_crediticio.first.institucion
      odt.add_field :fecha_1, pagare.antecedente_crediticio.first.fecha
      odt.add_field :monto_1, pagare.antecedente_crediticio.first.monto
      odt.add_field :saldo_1, pagare.antecedente_crediticio.first.saldo
      odt.add_field :institucion_2, pagare.antecedente_crediticio.second_to_last.institucion
      odt.add_field :fecha_2, pagare.antecedente_crediticio.second_to_last.fecha
      odt.add_field :monto_2, pagare.antecedente_crediticio.second_to_last.monto
      odt.add_field :saldo_2, pagare.antecedente_crediticio.second_to_last.saldo
      odt.add_field :institucion_3, pagare.antecedente_crediticio.last.institucion
      odt.add_field :fecha_3, pagare.antecedente_crediticio.last.fecha
      odt.add_field :monto_3, pagare.antecedente_crediticio.last.monto
      odt.add_field :saldo_3, pagare.antecedente_crediticio.last.saldo
      odt.add_field :re_1, pagare.referencia_personal_pagare.first.nombre
      odt.add_field :red_1, pagare.referencia_personal_pagare.first.domicilio
      odt.add_field :tf_1, pagare.referencia_personal_pagare.first.telefono
      odt.add_field :re_2, pagare.referencia_personal_pagare.last.nombre
      odt.add_field :red_2, pagare.referencia_personal_pagare.last.domicilio
      odt.add_field :tf_2, pagare.referencia_personal_pagare.last.telefono
      odt.add_field :fiador_nombre_1, pagare.socio.fiador.first.display_name
      odt.add_field :fiador_cedula_1, pagare.socio.fiador.first.numero_cedula
      odt.add_field :fiador_municipio_1, pagare.socio.fiador.first.municipio
      odt.add_field :fiador_domicilio_1, pagare.socio.fiador.first.domicilio
      odt.add_field :fiador_estado_civil_1  , pagare.socio.fiador.first.estado_civil.display_name
      odt.add_field :fiador_conyuge_1, pagare.socio.fiador.first.nombre_conyuge
      odt.add_field :fiador_profesion_1, pagare.socio.fiador.first.profesion
      odt.add_field :fiador_lugar_1, pagare.socio.fiador.first.lugar_trabajo
      odt.add_field :fiador_direccion_1, pagare.socio.fiador.first.direccion_domicilio
      odt.add_field :fiador_telefono_1, pagare.socio.fiador.first.telefono
      odt.add_field :fiador_t_labo_1, pagare.socio.fiador.first.tiempo_laborar
      odt.add_field :f_i_m_1, pagare.socio.fiador.first.salario_mensual
      odt.add_field :f_e_m_1, pagare.socio.fiador.first.egreso_mensual
      odt.add_field :fiador_d_1, pagare.socio.fiador.first.disponibilidad_al_mes
      odt.add_field :f_t_1, pagare.socio.fiador.first.tiempo_conocer_solicitante
      odt.add_field :a_n_1, pagare.socio.fiador.first.anio_parentesco
      odt.add_field :fiador_nombre_2, pagare.socio.fiador.last.display_name
      odt.add_field :fiador_cedula_2, pagare.socio.fiador.last.numero_cedula
      odt.add_field :fiador_municipio_2, pagare.socio.fiador.last.municipio
      odt.add_field :fiador_domicilio_2, pagare.socio.fiador.last.domicilio
      odt.add_field :fiador_estado_civil_2  , pagare.socio.fiador.last.estado_civil.display_name
      odt.add_field :fiador_conyuge_2, pagare.socio.fiador.last.nombre_conyuge
      odt.add_field :fiador_profesion_2, pagare.socio.fiador.last.profesion
      odt.add_field :fiador_lugar_2, pagare.socio.fiador.last.lugar_trabajo
      odt.add_field :fiador_direccion_2, pagare.socio.fiador.last.direccion_domicilio
      odt.add_field :fiador_telefono_2, pagare.socio.fiador.last.telefono
      odt.add_field :fiador_t_labo_2, pagare.socio.fiador.last.tiempo_laborar
      odt.add_field :f_i_m_2, pagare.socio.fiador.last.salario_mensual
      odt.add_field :f_e_m_2, pagare.socio.fiador.last.egreso_mensual
      odt.add_field :fiador_d_2, pagare.socio.fiador.last.disponibilidad_al_mes
      odt.add_field :f_t_2, pagare.socio.fiador.last.tiempo_conocer_solicitante
      odt.add_field :a_n_2, pagare.socio.fiador.last.anio_parentesco
      odt.add_field :garantia_hipotecaria, pagare.garantia_hipotecaria
      odt.add_field :leche_dia, pagare.cantidad_leche_entregada
      odt.add_field :observaciones, pagare.observaciones
    end

    send_data reporte.generate, type: "application/vnd.oasis.opendocument.text", disposition: "attachment",
                                      filename: "Pagare.odt"
  end

  def calendario_pdf
    pagare = Pagare.find(params[:q][:id])
    respond_to do |format|
      format.pdf do
        render pdf: "pagare.pdf", template: "pagares/calendario.html.erb", locals: { registro: pagare }
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

    def configurar_pagare
      @registro.usuario_id = current_usuario.id
      @registro.tipo_moneda_id = TipoMoneda::DOLAR
    end

    def pagare_params
      params.require(:pagare)
            .permit(:id, :numero_pagare, :plazo_id, :destino_credito, :garantias_ofrecidas,
                    :garantia_hipotecaria, :cantidad_solicitada, :cuota_pagar, :ubicacion_inversion,
                    :aceptar_condiciones_diferentes, :observaciones, :tuvo_credito, :tiene_credito_actualmente,
                    :interes_id, :socio_id, :cantidad_leche_entregada, :forma_pago,
                    antecedente_crediticio_attributes: [:id, :pagare_id, :institucion, :monto, :fecha, :saldo],
                    referencia_personal_pagare_attributes: [:id, :pagare_id, :nombre, :domicilio, :telefono])
    end

    alias :params_permit :pagare_params
end
