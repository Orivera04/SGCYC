# frozen_string_literal: true

class Ability
  include CanCan::Ability

  # Constantes del Menu
  RUTA = 1
  ICONO = 2

  def initialize(usuario)
    usuario ||= Usuario.new
    if usuario.rols_id == Rol::ADMINISTRADOR
      can :manage, :all
    else
      recurso = Recurso.all
      acciones_permitidas = RolAccion.where(rol_id: usuario.rols_id)
      validar_permiso_recurso(acciones_permitidas, recurso)
    end
  end

  def validar_permiso_recurso(acciones_permitidas, recurso)
    recurso.each do |recurso|
      acciones_recurso = acciones_permitidas.select{|accion| accion.recurso_id == recurso.id}
      acciones_recurso.each do |permiso|
        case permiso.accion_id
          when Accion::LECTURA
            can :read, recurso.nombre.to_sym
          when Accion::ESCRITURA
            can :create, recurso.nombre.to_sym
          when Accion::ACTUALIZAR
            can :update, recurso.nombre.to_sym
          when Accion::ELIMINAR
            can :destroy, recurso.nombre.to_sym
        end
      end
    end
  end
end