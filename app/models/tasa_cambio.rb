class TasaCambio < ApplicationRecord
    validates :tasa_cambio, presence: true
    validates_numericality_of :tasa_cambio, greater_than_or_equal_to: 1
    validates :fecha, presence: true
    validates_uniqueness_of :fecha

    scope :mes_eq, -> { where(fecha: Date.today.beginning_of_month..Date.today.end_of_month)}

    def self.ransackable_scopes(auth_object = nil)
        [:mes_eq]
    end
end
