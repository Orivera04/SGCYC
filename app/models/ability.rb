# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(usuario, modelo)
    usuario ||= Usuario.new
    if usuario.roles_id == Rol::ADMINISTRADOR
      can :manage, :all
    else
      recurso = Recurso.where(modelo: modelo.to_s).first
      acciones_permitidas = RolAccion.where(rols_id: usuario.roles_id,
                                            recursos_id: recurso.id)
      validar_permiso_recurso(acciones_permitidas, modelo)
    end
  end

  def validar_permiso_recurso(acciones_permitidas, modelo)
    acciones_permitidas.each do |permiso|
      case permiso.accion_id
        when Accion::LECTURA
          can :read, modelo
        when Accion::ESCRITURA
          can :create, modelo
        when Accion::ACTUALIZAR
          can :update, modelo
        when Accion::ELIMINAR
          can :destroy, modelo
      end
    end
  end
end
