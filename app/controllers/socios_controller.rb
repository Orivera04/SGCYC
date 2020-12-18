class SociosController < ApplicationController
    
    #listar los socios
    def index
        @socios = Socio.all
    end

    #agregar un socio
    def new
        @socio = Socio.new
    end

    def create
        @socio = Socio.new(socio_params)
        if @socio.save
            redirect_to socios_path
            #redirect_to :action => 'list'
        else
            #flash.now[:error] = "Could not save socio"
            render :new 
            #@socios = Socio.all
            #render :action => 'new'
        end
    end

    #private
    def socio_params 
        params.require(:socio).permit(:codigo_socio, :nombre, :apellido, :numero_cedula, :numero_ruc, :direccion, :telefono, :correo, :estado)
    end

end
