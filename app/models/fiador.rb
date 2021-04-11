class Fiador < ApplicationRecord
    belongs_to :socio
    belongs_to :estado_civil

    def display_name
        "#{nombre} #{apellido}"
    end
end
