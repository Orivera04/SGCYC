class ApplicationController < ActionController::Base
    include MenuHelper

    rescue_from CanCan::AccessDenied do |exception|
        redirect_back(fallback_location: root_path, alert: "Usuario no autorizado para realizar esta operación.")
    end

    def current_ability
        @current_ability ||= Ability.new(current_usuario)
    end
end
