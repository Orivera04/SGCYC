class Escolaridad < ApplicationRecord
    PRIMARIA = 1
    SECUNDARIA = 2
    UNIVERSIDAD = 3

    def display_name
        nombre
    end
end
