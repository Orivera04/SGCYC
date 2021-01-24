module Controleable
    extend ActiveSupport::Concern

    included do
        before_action :authenticate_usuario!
        before_action :buscar_registro, only: %i[edit new show destroy]
        before_action :actualizar_crear_registro, only: %i[create update]
    end

    def buscar_registro
        if params[:id].present?
            @registro = Rol.find(params[:id])
            @url = send([controller_name.singularize, 'path'].join('_'), @registro)
        else
            @registro = Rol.new
            @url = send([controller_name, 'path'].join('_'), @registro)
        end
    end

    def actualizar_crear_registro
        if params[:id].present?
          @registro = class_name.find(params[:id])
          @url = send([controller_name.singularize, 'path'].join('_'), @registro)
        else
          @registro = Rol.new(params_permit || {})
          @url = send([controller_name, 'path'].join('_'), @registro)
        end
    end
end