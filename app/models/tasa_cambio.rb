require 'savon'
class TasaCambio < ApplicationRecord
    validates :tasa_cambio, presence: true
    validates_numericality_of :tasa_cambio, greater_than_or_equal_to: 1
    validates :fecha, presence: true
    validates_uniqueness_of :fecha

    scope :mes_eq, -> { where(fecha: Date.today.beginning_of_month..Date.today.end_of_month)}

    def self.ransackable_scopes(auth_object = nil)
        [:mes_eq]
    end

    def self.ransackable_attributes(auth_object = nil)
        ["fecha", "id", "tasa_cambio"]
    end

    def self.consumir_webservice_bcn(mes)
        cliente = Savon.client(wsdl: "https://servicios.bcn.gob.ni/Tc_Servicio/ServicioTC.asmx?wsdl",  namespace: "http://servicios.bcn.gob.ni/",
                               ssl_verify_mode: :none, log_level: :debug, log: true, convert_request_keys_to: :none)
        respuesta = cliente.call(:recupera_tc_mes, message: { Ano: Date.today.year, Mes: mes.to_i }).body
        tasas_cambios =  respuesta[:recupera_tc_mes_response][:recupera_tc_mes_result][:detalle_tc][:tc]

        tasas_cambios&.each do |tasa|
            registro = TasaCambio.find_by_fecha(tasa[:fecha]) || TasaCambio.new
            registro.tasa_cambio = tasa[:valor]
            registro.fecha = tasa[:fecha]
            registro.save!
        end
    end

    def self.conversion_divisa(monto_convertir, moneda_origen_id, moneda_destino_id, fecha)
        tasa_cambio = TasaCambio.find_by_fecha(fecha)&.tasa_cambio || 1
        if (moneda_origen_id == TipoMoneda::CORDOBA && moneda_destino_id == TipoMoneda::DOLAR)
            monto_convertir / tasa_cambio
        elsif (moneda_origen_id == TipoMoneda::DOLAR && moneda_destino_id == TipoMoneda::CORDOBA)
            monto_convertir * tasa_cambio
        else
            monto_convertir
        end
    end
end
