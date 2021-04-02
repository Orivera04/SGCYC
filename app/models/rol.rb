class Rol < ApplicationRecord
    ADMINISTRADOR = 1
    ID = 0
    ROL_ID = 1
    RECURSO_ID = 2
    ACCION_ID = 3
    MARCADO = 1
    DESMARCADO = 0

    has_many :rol_accion, dependent: :destroy, inverse_of: :rol
    accepts_nested_attributes_for :rol_accion, allow_destroy: true
    validates :nombre, presence: true
    before_validation :eliminar_permisos_desmarcados
    before_destroy :validate_destroy

    # Este metodo elimina las acciones que fueron desmarcadas por el usuario
    def eliminar_permisos_desmarcados
        rol_accion.each do |accion|
            accion.mark_for_destruction unless accion.marcado
        end
    end

    def validate_destroy
        if Usuario.where(rols_id: id ).any?
            raise StandardError.new "No se puede eliminar el rol, este se encuentra vinculado a un usuario"
        end
    end
end
