class Cuota < ApplicationRecord
    PORCENTAJE_MORA = 0.02
    belongs_to :pagare
    after_save :cambiar_estado_pagare

    def cambiar_estado_pagare
        monto_total = pagare.cuotas.sum(&:cuota) - pagare.cuotas.sum(&:monto_abonado)
        pagare.update_columns(cancelado: monto_total == Comprobante::SALDO_CERO)
    end

    def calcular_mora
        return mora if mora.present?
        return Comprobante::SALDO_CERO if Date.today <= fecha_pago
        diferencial_dias = (Date.today - fecha_pago).to_i
        (((cuota - monto_abonado) * PORCENTAJE_MORA) * diferencial_dias).truncate(2)
    end

    def monto_con_mora
        cuota + calcular_mora
    end
end
