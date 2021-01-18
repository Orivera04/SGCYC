module MenuHelper
    # Este Helper sirve para construir el menu de la interfaz
    # a partir de los permisos que posea el usuario

    def contruir_menu
        acciones_permitidas = []
        ruta_archivo = File.join(Rails.root, "config", "menu.yml")
        menu = YAML.load_file(ruta_archivo)

        menu.each_with_index do |seccion, indice|
            sub_sessiones_permitidas = []

            # Determinamos si la sección tiene Sub Items
            if seccion.values.flatten.first.key?("Items")
                seccion.values.flatten.first["Items"].each do |sub_seccion|
                    if validar_permiso_item(sub_seccion.values.first["Recurso"])
                        sub_sessiones_permitidas.push(sub_seccion)
                    end
                end

                if sub_sessiones_permitidas.length > 0
                    seccion.values.flatten.first["Items"] = sub_sessiones_permitidas
                    acciones_permitidas.push(seccion)
                end
            else
                if validar_permiso_item(seccion.values.flatten.first["Recurso"])
                    acciones_permitidas.push(seccion)
                end
            end
        end
        acciones_permitidas
    end

    def validar_permiso_item(recurso)
        can? :read, recurso.to_sym
    end
end