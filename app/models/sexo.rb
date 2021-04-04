class Sexo < ApplicationRecord
    MASCULINO = 1
    FEMENINO = 2

    def display_name
        nombre
    end
end
