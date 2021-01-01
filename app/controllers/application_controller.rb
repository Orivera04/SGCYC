class ApplicationController < ActionController::Base

    rescue_from CanCan::AccessDenied do |exception|
        redirect_to root_url, alert: "Usuario no autorizado para realizar esta operación."
    end

    def current_ability
        @current_ability ||= Ability.new(current_usuario)
    end
end
