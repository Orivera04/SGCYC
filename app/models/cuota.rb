class Cuota < ApplicationRecord
    belongs_to :pagare
    after_save :cambiar_estado_pagare

    def cambiar_estado_pagare
        monto_total = pagare.cuotas.sum(&:cuota) - pagare.cuotas.sum(&:monto_abonado)
        pagare.update_columns(cancelado: monto_total == Comprobante::SALDO_CERO)
    end
end
