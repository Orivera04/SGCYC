class Pagare < ApplicationRecord
    belongs_to :usuario
    belongs_to :socio
    belongs_to :tipo_moneda
    belongs_to :plazo
    belongs_to :interes

    has_many :antecedente_crediticio, dependent: :destroy, inverse_of: :pagare
    has_many :referencia_personal_pagare, dependent: :destroy, inverse_of: :pagare
    has_many :cuotas, dependent: :destroy, inverse_of: :pagare
    accepts_nested_attributes_for :antecedente_crediticio, allow_destroy: true
    accepts_nested_attributes_for :referencia_personal_pagare, allow_destroy: true

    validates :numero_pagare, presence: true
    validates :socio_id, presence: true
    validates :plazo_id, presence: true
    validates :cantidad_solicitada, presence: true
    validates :interes_id, presence: true
    validates :destino_credito, presence: true
    validates :ubicacion_inversion, presence: true
    validates :garantias_ofrecidas, presence: true
    validates :garantia_hipotecaria, presence: true
    validates :observaciones, presence: true
    validates :cuota_pagar, presence: true
    after_create_commit  :crear_cuotas

    def obtener_numero
        (numero_pagare.nil?) ? Pagare.count + 1 : numero_pagare
    end

    def crear_cuotas
        monto_dolares = TasaCambio.conversion_divisa(cantidad_solicitada, TipoMoneda::CORDOBA,
                                                     TipoMoneda::DOLAR, Date.today).round(2)

        porcentaje_interes = (self.interes.cantidad.to_d / 100)
        cantidad_plazo = plazo.plazo
        porcentaje_interes_mensual = porcentaje_interes / cantidad_plazo
        monto_plazo = (monto_dolares / cantidad_plazo).round(2)
        cuota_plazo = (monto_plazo + (monto_plazo * porcentaje_interes_mensual)).round(2)

        cantidad_plazo.times do |plazo|
            cuota = Cuota.new(pagare_id: self.id, fecha_pago: (Date.today + (plazo.next).month), numero_cuota: plazo.next,
                              cuota: cuota_plazo, monto_abonado: 0, cancelado: false)
            cuota.save!
        end

    end

    def self.obtener_cuotas_pagare(pagare_id)
        pagare_usuario = Pagare.find(pagare_id)
        cuotas = pagare_usuario.cuotas.order("numero_cuota")
        cuotas_pendientes = cuotas.where(cancelado: false).order("numero_cuota")
        proxima_cuota = cuotas_pendientes.first

        total_pendiente = cuotas_pendientes.sum(&:cuota)
        monto_cuota = proxima_cuota.cuota
        numero_cuota = proxima_cuota.numero_cuota
        monto_pendiente_cuota = proxima_cuota.cuota - proxima_cuota.monto_abonado

        {
            total_pendiente: "#{total_pendiente} #{TipoMoneda.obtener_simbolo_moneda(TipoMoneda::DOLAR)}",
            monto_cuota: "#{monto_cuota} #{TipoMoneda.obtener_simbolo_moneda(TipoMoneda::DOLAR)}",
            numero_cuota: numero_cuota,
            monto_pendiente_cuota: "#{monto_pendiente_cuota} #{TipoMoneda.obtener_simbolo_moneda(TipoMoneda::DOLAR)}"
        }
    end
end
