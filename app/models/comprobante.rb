class Comprobante < ApplicationRecord
    belongs_to :socio
    belongs_to :pagare
    belongs_to :usuario

    has_many :comprobante_detalle, dependent: :destroy, inverse_of: :comprobante
    accepts_nested_attributes_for :comprobante_detalle, allow_destroy: true

    def obtener_numero
        (numero_comprobante.nil?) ? Comprobante.count + 1 : numero_comprobante
    end
end
