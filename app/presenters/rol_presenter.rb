class RolPresenter < SimpleDelegator
    def initialize(modelo)
        @permisos = modelo.rol_accion
        super(@permisos)
    end

    def permiso_activo(recurso_id, accion_id)
        (@permisos.select{|permiso| permiso.recurso_id == recurso_id && permiso.accion_id == accion_id}.any?) ? true : false
    end

    def encontrar_identificador(recurso_id, accion_id)
        identificador = @permisos.select{|permiso| permiso.recurso_id == recurso_id && permiso.accion_id == accion_id}
        (identificador.any?) ? identificador.first.id : ""
    end
end