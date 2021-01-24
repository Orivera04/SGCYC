class wstasa_cambio
    attr_reader :Fecha, :Valor, :Ano, :Mes, :Dia
    def self.post_webservice(anio, mes)
        client = Savon.client("https://servicios.bcn.gob.ni/Tc_Servicio/ServicioTC.asmx?wsdl")
        mensaje = {"Ano" => anio, "Mes" => mes}

        response = client.call(:RecuperaTC_Mes, message: mensaje)
        #if response.succes?
    end
end