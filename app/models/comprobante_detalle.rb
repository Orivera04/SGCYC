class ComprobanteDetalle < ApplicationRecord
    belongs_to :comprobante
    validates_numericality_of :monto_pagado, greater_than_or_equal_to: 0

end
