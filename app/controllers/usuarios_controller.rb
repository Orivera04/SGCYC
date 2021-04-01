class UsuariosController < ApplicationController
    include Controleable
    before_action :authenticate_usuario!
    before_action :coleccion_inicial, only: %i[index excel_index]

    def coleccion_inicial
        params[:q] ||= {}
        @coleccion = Usuario.ransack(params[:q])
        respond_to do |formato|
            formato.html do
                @registros = @coleccion.result.page(params[:page])
            end
            formato.xlsx do
                @registros = @coleccion.result
            end
        end
    end

    def index
        authorize!(:read, :Usuario)
        @params_permit = params[:q].present? ? {q: params[:q] .permit! } : {}
        render template: "usuarios/index",  layout: "layouts/application"
    end

    def new
        authorize!(:create, :Usuario)
        render template: "usuarios/form", layout: "layouts/application"
    end

    def show
        authorize!(:update, :Usuario)
        render template: "usuarios/form", layout: "layouts/application"
    end

    def edit
        authorize!(:update, :Usuario)
        render template: "usuarios/form", layout: "layouts/application"
    end

    def excel_index
        respond_to do |formato|
            formato.xlsx do
                render(
                    xlsx: "excel_index",
                    filename: "Usuarios del sistema - #{Date.today}.xlsx"
                )
            end
        end
    end

    def create
        begin
            raise if flash.now[:error].present?
                if @registro.save!
                    flash[:notice] = "El registro fue guardado exitosamente"
                    redirect_to action: :index
            end
        rescue StandardError => e
            flash[:error] = "Ocurrio un error al guardar los datos" if flash.now[:error].blank?
            render template: "usuarios/form", layout: "layouts/application"
        end
    end

    def update
        begin
            raise if flash.now[:error].present?
            if @registro.save!
                flash[:notice] = "El registro fue actualizado exitosamente"
                redirect_to action: :index
            end
        rescue StandardError => e
            flash[:error] = "Ocurrio un error al actualizar los datos" if flash.now[:error].blank?
            render template: "usuarios/form", layout: "layouts/application"
        end
    end

    def destroy
        authorize!(:destroy, :Usuario)
        begin
            flash[:notice] = "El registro ha sido eliminado exitosamente" if @registro.destroy
        rescue StandardError => e
            flash[:error] = e.message
        end

        redirect_to action: :index, search: params[:q]
    end

    private

    def nombre_recurso
        "Usuario"
    end

    def usuario_params
        params.require(:usuarios).permit(:id, :email, :password, :nombre,
                                         :roles_id, :cargos_id, :activo)
    end

    alias :params_permit :usuario_params
end