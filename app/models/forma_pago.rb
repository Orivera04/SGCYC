class FormaPago < ApplicationRecord
    validates :nombre, presence: true
    belongs_to :tipo_moneda
end
