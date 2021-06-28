class PagarePresenter < SimpleDelegator
    def initialize(modelo)
        @modelo = modelo
        super(@modelo)
    end

    def obtener_monto_financiado
        "#{TasaCambio.conversion_divisa(@modelo.cantidad_solicitada, TipoMoneda::CORDOBA,
                                                     TipoMoneda::DOLAR, @modelo.created_at.to_date).round(2)} USD"
    end


    def obtener_cuotas
        numero_cuotas = @modelo.plazo.plazo
        cuotas_pagadas = @modelo.cuotas.select{|cuota| cuota.cancelado}.size
        "#{cuotas_pagadas} / #{numero_cuotas}"
    end

    def obtener_monto_restante
        monto_financiado = @modelo.cuotas.sum(&:monto_con_mora)
        monto_pagado = @modelo.cuotas.sum(&:monto_abonado)
        monto_restante = monto_financiado - monto_pagado
        "#{monto_restante} USD"
    end

    def estado_pago(pago)
        (pago.cancelado) ? "Pagado" : "Pendiente"
    end
end