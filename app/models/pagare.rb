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

    validates_numericality_of :cantidad_leche_entregada, greater_than_or_equal_to: 0
    validates_numericality_of :cantidad_solicitada, greater_than_or_equal_to: 0
    validates_numericality_of :cuota_pagar, greater_than_or_equal_to: 0

    def self.ransackable_attributes(auth_object = nil)
        ["aceptar_condiciones_diferentes", "cancelado", "cantidad_leche_entregada", "cantidad_solicitada", "created_at", "cuota_pagar", "destino_credito", "forma_pago", "garantia_hipotecaria", "garantias_ofrecidas", "id", "interes_id", "numero_pagare", "observaciones", "plazo_id", "socio_id", "tiene_credito_actualmente", "tipo_moneda_id", "tuvo_credito", "ubicacion_inversion", "updated_at", "usuario_id"]
    end

    def obtener_numero
        (numero_pagare.nil?) ? Pagare.count + 1 : numero_pagare
    end

    def crear_cuotas
        monto_dolares = TasaCambio.conversion_divisa(cantidad_solicitada, TipoMoneda::CORDOBA,
                                                     TipoMoneda::DOLAR, Date.today).round(2)

        porcentaje_interes = (self.interes.cantidad.to_d)
        cantidad_plazo = plazo.plazo

        interes_por_mes = porcentaje_interes / (12 * 100)
        cuota_nivelada = monto_dolares * interes_por_mes * ((1 + interes_por_mes)**cantidad_plazo)/((1+interes_por_mes)**cantidad_plazo - 1)

        cantidad_plazo.times do |plazo|
            cuota = Cuota.new(pagare_id: self.id, fecha_pago: (Date.today + (plazo.next).month), numero_cuota: plazo.next,
                              cuota: cuota_nivelada, monto_abonado: 0, cancelado: false)
            cuota.save!
        end

    end

    def self.obtener_cuotas_pagare(pagare_id)
        pagare_usuario = Pagare.find(pagare_id)
        cuotas = pagare_usuario.cuotas.order("numero_cuota")
        cuotas_pendientes = cuotas.where(cancelado: false).order("numero_cuota")
        proxima_cuota = cuotas_pendientes.first

        total_pendiente = cuotas_pendientes.sum(&:monto_con_mora)
        monto_cuota = proxima_cuota.monto_con_mora
        numero_cuota = proxima_cuota.numero_cuota
        monto_pendiente_cuota = proxima_cuota.monto_con_mora - proxima_cuota.monto_abonado

        {
            total_pendiente: "#{total_pendiente} #{TipoMoneda.obtener_simbolo_moneda(TipoMoneda::DOLAR)}",
            monto_cuota: "#{monto_cuota} #{TipoMoneda.obtener_simbolo_moneda(TipoMoneda::DOLAR)}",
            numero_cuota: numero_cuota,
            monto_pendiente_cuota: "#{monto_pendiente_cuota} #{TipoMoneda.obtener_simbolo_moneda(TipoMoneda::DOLAR)}"
        }
    end
end
