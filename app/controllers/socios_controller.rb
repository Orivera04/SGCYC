class SociosController < ApplicationController
    
    #listar los socios
    def index
        @socios = Socio.all
    end

    #agregar un socio
    def new
        @socio = Socio.new
    end

end
