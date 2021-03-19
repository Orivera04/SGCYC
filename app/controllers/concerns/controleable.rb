module Controleable
    extend ActiveSupport::Concern

    included do
        before_action :authenticate_usuario!
        before_action :buscar_registro, only: %i[edit new show destroy]
        before_action :actualizar_crear_registro, only: %i[create update]
    end

    def buscar_registro
        if params[:id].present?
            @registro =  nombre_recurso.constantize.find(params[:id])
            @url = send([controller_name.singularize, "path"].join("_"), @registro)
        else
            @registro =  nombre_recurso.constantize.new
            @url = send([controller_name, "path"].join("_"), @registro)
        end
    end

    def actualizar_crear_registro
        if params[:id].present?
          @registro = nombre_recurso.constantize.find(params[:id])
          @url = send([controller_name.singularize, "path"].join("_"), @registro)
          @registro.attributes = params_permit || {}
        else
          @registro =  nombre_recurso.constantize.new(params_permit || {})
          @url = send([controller_name, "path"].join("_"), @registro)
        end
    end
end