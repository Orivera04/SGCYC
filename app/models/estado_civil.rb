class EstadoCivil < ApplicationRecord
    SOLTERO = 1
    CASADO = 2
    VIUDO = 3

    def display_name
        nombre
    end
end
