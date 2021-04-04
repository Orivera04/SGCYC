class Pagare < ApplicationRecord
    belongs_to :usuario
    belongs_to :socio
    belongs_to :tipo_moneda
    belongs_to :plazo
    belongs_to :interes

    has_many :antecedente_crediticio, dependent: :destroy, inverse_of: :pagare
    has_many :referencia_personal_pagare, dependent: :destroy, inverse_of: :pagare
    accepts_nested_attributes_for :antecedente_crediticio, allow_destroy: true
    accepts_nested_attributes_for :referencia_personal_pagare, allow_destroy: true

    def obtener_numero
        (numero_pagare.nil?) ? Pagare.count + 1 : numero_pagare
    end
end
