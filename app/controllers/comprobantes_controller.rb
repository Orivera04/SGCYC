class ComprobantesController < ApplicationController
    include Controleable
    before_action :authenticate_usuario!
    before_action :configurar_comprobante, only: %i[create]
    before_action :coleccion_inicial, only: %i[index excel_index]

    def coleccion_inicial
      params[:q] ||= {}
      @coleccion = Comprobante.ransack(params[:q])
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
      authorize!(:read, :Comprobante)
      @params_permit = params[:q].present? ? {q: params[:q] .permit! } : {}
      render template: "comprobantes/index",  layout: "layouts/application"
    end

    def new
      authorize!(:create, :Comprobante)
      render template: "comprobantes/form", layout: "layouts/application"
    end

    def show
      authorize!(:update, :Comprobante)
      render template: "comprobantes/form", layout: "layouts/application"
    end

    def edit
      authorize!(:update, :Comprobante)
      @params_permit = params.present? ? {q: params.permit! } : {}
      render template: "comprobantes/form", layout: "layouts/application"
    end

    def excel_index
      respond_to do |formato|
        formato.xlsx do
          render(
            xlsx: "excel_index",
            filename: "Comprobantes del sistema - #{Date.today}.xlsx"
          )
        end
      end
    end

    def comprobante_odt
      comprobante = Comprobante.find(params[:q][:id])
      reporte = ODFReport::Report.new( Rails.root.join("app", "assets/documents/comprobante.odt")) do |odt|

      end

      send_data reporte.generate, type: "application/vnd.oasis.opendocument.text", disposition: "attachment",
                                        filename: "Comprobante.odt"
    end

    def create
      begin
        if @registro.save!
          flash[:notice] = "El registro fue guardado exitosamente"
          redirect_to action: :index
        end
      rescue StandardError => e
        flash[:error] = "Ocurrio un error al guardar los datos" if flash.now[:error].blank?
        render template: "comprobantes/form", layout: "layouts/application"
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
        render template: "comprobantes/form", layout: "layouts/application"
      end
    end

    def destroy
      authorize!(:destroy, :Comprobante)
      begin
        flash[:notice] = "El registro ha sido eliminado exitosamente" if @registro.destroy
      rescue StandardError => e
        flash[:alert] = e.message
      end

      redirect_to action: :index, search: params[:q]
    end

    def obtener_pagare_socios
      pagare_usuario = Pagare.where(socio_id: params[:socio_id], cancelado: false)
      opciones = view_context.options_from_collection_for_select(pagare_usuario, :id, :numero_pagare)
      render json: { lista: opciones}, status: Rack::Utils::SYMBOL_TO_STATUS_CODE[:ok]
    end

    def obtener_informacion_cuotas
      pagare_usuario = Pagare.obtener_cuotas_pagare(params[:pagare_id])
      render json: { total_pendiente: pagare_usuario[:total_pendiente], monto_cuota: pagare_usuario[:monto_cuota], numero_cuota: pagare_usuario[:numero_cuota],
                     monto_pendiente_cuota: pagare_usuario[:monto_pendiente_cuota]}, status: Rack::Utils::SYMBOL_TO_STATUS_CODE[:ok]
    end

    def obtener_totales
      totales = FormaPago.procesar_totales(params[:pagos])
      render json: { total: totales[:total_formateado], pagos: totales[:pagos] }, status: Rack::Utils::SYMBOL_TO_STATUS_CODE[:ok]
    end

    def configurar_comprobante
      totales = FormaPago.procesar_totales(@registro.comprobante_detalle)
      @registro.usuario_id = current_usuario.id
      @registro.monto_pagado = totales[:total]
    end

    def comprobante_odt
      comprobante = Comprobante.find(params[:q][:id])
      totales = FormaPago.procesar_totales(comprobante.comprobante_detalle)
      reporte = ODFReport::Report.new( Rails.root.join("app", "assets/documents/comprobante.odt")) do |odt|
        odt.add_field :numero, comprobante.numero_comprobante
        odt.add_field :cliente, comprobante.socio.display_name
        odt.add_field :cedula, comprobante.socio.numero_cedula
        odt.add_field :direccion, comprobante.socio.direccion_domiciliar
        odt.add_field :telefono, comprobante.socio.numero_telefono
        odt.add_field :fecha, comprobante.created_at
        odt.add_field :plazo, comprobante.pagare.plazo.plazo
        odt.add_field :vendedor, comprobante.usuario.nombre
        odt.add_field :total_pagado, totales[:total_formateado]

        odt.add_field :f_0, totales[:pagos][0].try(:[], :nombre_pago)
        odt.add_field :f_1, totales[:pagos][1].try(:[], :nombre_pago)
        odt.add_field :f_2, totales[:pagos][2].try(:[], :nombre_pago)
        odt.add_field :f_3, totales[:pagos][3].try(:[], :nombre_pago)
        odt.add_field :f_4, totales[:pagos][4].try(:[], :nombre_pago)

        odt.add_field :m_0, totales[:pagos][0].try(:[], :monto_convertido)
        odt.add_field :m_1, totales[:pagos][1].try(:[], :monto_convertido)
        odt.add_field :m_2, totales[:pagos][2].try(:[], :monto_convertido)
        odt.add_field :m_3, totales[:pagos][3].try(:[], :monto_convertido)
        odt.add_field :m_4, totales[:pagos][4].try(:[], :monto_convertido)

        odt.add_field :o_0, totales[:pagos][0].try(:[], :referencia)
        odt.add_field :o_1, totales[:pagos][1].try(:[], :referencia)
        odt.add_field :o_2, totales[:pagos][2].try(:[], :referencia)
        odt.add_field :o_3, totales[:pagos][3].try(:[], :referencia)
        odt.add_field :o_4, totales[:pagos][4].try(:[], :referencia)
      end

      send_data reporte.generate, type: "application/vnd.oasis.opendocument.text", disposition: "attachment",
                                        filename: "Comprobante.odt"
    end

    private

      def nombre_recurso
        "Comprobante"
      end

      def comprobante_params
        params.require(:comprobante)
              .permit(:id, :numero_comprobante, :pagare_id, :usuario_id, :socio_id, :tipo_moneda_id,
                      :monto_pagado, :observacion,
                      comprobante_detalle_attributes: [:id, :comprobante_id, :forma_pago_id, :monto_pagado,
                                                        :referencia])
      end

      alias :params_permit :comprobante_params
end