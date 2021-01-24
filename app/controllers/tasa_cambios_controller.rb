class TasaCambiosController < ApplicationController
     before_action :authenticate_usuario!

     #listar 
     def index
      #@search = TasaBuscar.new(params[:search])
      #@tasa_cambios = @search.scope

      #ransack search
          @search = TasaCambio.ransack(params[:q])
          @tasa_cambios = @search.result
     end

     def search
          index
          render :index
     end

      #agregar
     def new
          @tasa_cambio = TasaCambio.new

          #anio = "#params[:year]"
          #mes = "#params[:month]"

          #@wstasa = @wstasa_cambio.new(anio,mes)

     end

     def create
          @tasa_cambio = TasaCambio.new(tcambio_params)
          if @tasa_cambio.save
               redirect_to tasa_cambios_path
          else
               render :new 
          end
     end

     #editar
     def edit 
          @tasa_cambio = TasaCambio.find(params[:id])
     end

     # def update
     #      @tasa_cambio = TasaCambio.find(params[:id])
     #      #if @tasa_cambio.update_attributes(params[:tasa_cambio])
     #      @tasa_cambio.update(fecha: params[:tasa_cambio][:fecha], dolar: params[:tasa_cambio][:dolar], cordoba: params[:tasa_cambio][:cordoba])
     #           # Handle a successful update.
     #      #else
     #           render :edit
     #      #end

     # end

     def update 
          @tasa_cambio = TasaCambio.find(params[:id])
          if @tasa_cambio.update(tcambio_params)
               redirect_to tasa_cambios_path
          else
               render :edit 
          end
     end

     def delete
          @tasa_cambio = TasaCambio.find(params[:id])
          @tasa_cambio.destroy
          redirect_to index
     end

     #private
     def tcambio_params 
          params.require(:tasa_cambio).permit(:fecha, :dolar, :cordoba)
     end

     def masivo
          binding.pry
          @tasa_cambios = TasaCambio.new
          render :masivo
     end

     def self.post_webservice(year, month)
          date = { Ano: year, Mes: month }
          begin
            client = Savon.client(log: true, ssl_verify_mode: :none, ssl_version: :TLSv1) do
              wsdl 'https://servicios.bcn.gob.ni/Tc_Servicio/ServicioTC.asmx?WSDL'
              convert_request_keys_to :camelcase
            end
      
            client.call(:recupera_tc_mes, message: date).body
          rescue StandardError => e
            logger.error '*******************'
            logger.error e.message
            logger.error e.backtrace.join('\n')
            logger.error '*******************'
            raise e.message
          end
        end

     def respuesta
     end

end
