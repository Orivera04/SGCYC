class Rol < ApplicationRecord
    ADMINISTRADOR = 1
    ID = 0
    ROL_ID = 1
    RECURSO_ID = 2
    ACCION_ID = 3

    has_many :rol_accion, dependent: :destroy, inverse_of: :rol
    accepts_nested_attributes_for :rol_accion, allow_destroy: true
    validates :nombre, presence: true

end
