class TipoDomicilio < ApplicationRecord
    PROPIO = 1
    ALQUILADO = 2
    FAMILIAR = 3

    def display_name
        nombre
    end
end
