class TipoMoneda < ApplicationRecord
    CORDOBA = 1
    DOLAR = 2

    def self.obtener_simbolo_moneda(tipo_moneda_id)
        where(id: tipo_moneda_id).first.simbolo
    end
end
