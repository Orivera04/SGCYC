# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(usuario)
    usuario ||= Usuario.new
    if usuario.roles_id == Rol::ADMINISTRADOR
      can :manage, :all
    else
      can :delete, :all
    end
  end
end
