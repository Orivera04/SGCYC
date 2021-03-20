class EmpresaPresenter < SimpleDelegator
    def initialize(modelo)
        @modelo = modelo
        super(@model)
    end

    # Obtiene el logo de la empresa
    def logo_empresa
        @modelo.logo_imagen
    end
end