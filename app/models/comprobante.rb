class Comprobante < ApplicationRecord
    SALDO_CERO = 0
    belongs_to :socio
    belongs_to :pagare
    belongs_to :usuario
    validate :validar_monto_pagado
    after_create_commit  :crear_pago_pagare
    before_destroy :validar_ultima_cuota
    before_destroy :revertir_cuotas

    has_many :comprobante_detalle, dependent: :destroy, inverse_of: :comprobante
    accepts_nested_attributes_for :comprobante_detalle, allow_destroy: true

    def obtener_numero
        (numero_comprobante.nil?) ? Comprobante.count + 1 : numero_comprobante
    end

    def validar_monto_pagado
        monto_total = pagare.cuotas.sum(&:cuota) - pagare.cuotas.sum(&:monto_abonado)
        errors.add(:pagare_id, "El monto pagado sobrepasa el restante del pagare") if monto_total < monto_pagado
    end

    def crear_pago_pagare
        cuotas_pendientes = Cuota.where(pagare_id: pagare_id, cancelado: false).order("fecha_pago asc")
        cuota_proxima_pagar = cuotas_pendientes.first
        monto_cuota_pagar = cuota_proxima_pagar.cuota - cuota_proxima_pagar.monto_abonado
        monto_pagado_socio = monto_pagado

        if monto_cuota_pagar >= monto_pagado_socio
            cuota_proxima_pagar.monto_abonado += monto_pagado_socio
            cuota_proxima_pagar.cancelado = true if cuota_proxima_pagar.monto_abonado == cuota_proxima_pagar.cuota
            cuota_proxima_pagar.save!
        else
            cuotas_pendientes.each do |cuota|
                break if monto_pagado_socio <= SALDO_CERO
                monto_cuota_pagar = cuota.cuota - cuota.monto_abonado

                cuota.monto_abonado += if monto_cuota_pagar >= monto_pagado_socio
                    monto_pagado_socio
                else
                    monto_cuota_pagar
                end

                cuota.cancelado = true if cuota.monto_abonado == cuota.cuota
                cuota.save!
                monto_pagado_socio -= monto_cuota_pagar
            end
        end
    end

    def validar_ultima_cuota
        comprobante = Comprobante.where(pagare_id: pagare_id).order("created_at desc").first
        raise StandardError.new "No se puede eliminar el comprobante, no es el ultimo creado" if comprobante != self
    end

    def revertir_cuotas
        cuotas_pagadas = Cuota.where(pagare_id: pagare_id, cancelado: true).order("fecha_pago desc")
        monto_pagado_socio = monto_pagado

        cuotas_pagadas.each do |cuota|
            break if monto_pagado_socio <= SALDO_CERO
            monto_cuota = cuota.monto_abonado
            monto_abonado = cuota.monto_abonado - monto_pagado

            cuota.monto_abonado = if monto_abonado > 0
                monto_abonado
            else
                SALDO_CERO
            end

            cuota.cancelado = false
            cuota.save!
            monto_pagado_socio -= if monto_abonado > 0
                monto_abonado
            else
                monto_cuota
            end
        end
    end
end
