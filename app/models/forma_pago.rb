class FormaPago < ApplicationRecord
    LECHE = 1
    validates :nombre, presence: true
    belongs_to :tipo_moneda
    belongs_to :tipo_pago

    def self.ransackable_attributes(auth_object = nil)
        ["bancos_id", "equivalencia", "id", "nombre", "tipo_moneda_id", "tipo_pago_id"]
    end


    def self.procesar_totales(pagos)
        total_pendiente = 0
        lista_pagos = []
        pagos.each do |pago|
            pago_id = pago.try(:forma_pago_id) || pago.last[:forma_pago_id]
            monto = pago.try(:monto_pagado) || pago.last[:monto].to_d

            forma_pago = FormaPago.find(pago_id)
            totales = FormaPago.obtener_monto_pago(forma_pago, monto )
            monto_pago = totales[:monto]
            tipo_moneda_id = totales[:tipo_moneda_id]
            monto_convertido = TasaCambio.conversion_divisa(monto_pago, tipo_moneda_id,
                                                     TipoMoneda::DOLAR, Date.today).round(2)

            lista_pagos.push(pago_id: pago_id, moneda: forma_pago.tipo_moneda.nombre,
                             monto_convertido: monto_convertido, referencia: pago.try(:referencia), nombre_pago: forma_pago.nombre)
        end
        {
            pagos: lista_pagos,
            total_formateado: "#{lista_pagos.map{ |pago| pago[:monto_convertido]}.sum} #{TipoMoneda.obtener_simbolo_moneda(TipoMoneda::DOLAR)}",
            total: lista_pagos.map{ |pago| pago[:monto_convertido]}.sum
        }
    end

    def self.obtener_monto_pago(forma_pago, monto)
        pago_monto = 0
        if forma_pago.tipo_pago_id == TipoPago::INTERCAMBIO
            pago_monto = forma_pago.equivalencia * monto
            tipo_moneda_id = TipoMoneda::CORDOBA
        elsif forma_pago.id == FormaPago::LECHE
            valor_leche = ValorLeche.find_by_fecha(Date.today)
            pago_monto = valor_leche.tasa_cambio * monto
            tipo_moneda_id = TipoMoneda::CORDOBA
        else
            pago_monto = monto if monto.present?
            tipo_moneda_id = forma_pago.tipo_moneda_id
        end

        {
            monto: pago_monto,
            tipo_moneda_id: tipo_moneda_id
        }
    end
end
