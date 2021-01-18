begin
    puts '==> Creando Seeds'

    puts '==> Creando Posiciones por defecto'
    Posicion.create!(id: 1, nombre: "Administrador del Sistema", descripcion: "Encargado de administrar el sistema")
    Posicion.create!(id: 2, nombre: "Gestor de Cobro", descripcion: "Encargado de realizar la cobranza")
    puts ': Realizado con exito.'

    puts '==> Creando Roles por defecto'
    Rol.create!(id: 1, nombre: "Administrador", estado: true)
    Rol.create!(id: 2, nombre: "Gestor de cobro", estado: true)
    puts ': Realizado con exito.'

    puts '==> Creando Tipo de Recursos por defecto'
    TipoRecurso.create!(id: 1, nombre: "Documentos")
    TipoRecurso.create!(id: 2, nombre: "Catalogo")
    TipoRecurso.create!(id: 3, nombre: "Dashboard")
    TipoRecurso.create!(id: 4, nombre: "Informes")
    TipoRecurso.create!(id: 5, nombre: "Configuración")
    puts ': Realizado con exito.'

    puts '==> Creando Recursos por Defecto'

    Recurso.create!(id: 1, nombre: "InformacionGeneral", descripcion: "Información General Dashboard", tipo_recurso_id: 3)
    Recurso.create!(id: 2, nombre: "Graficos", descripcion: "Graficos del Dashboard", tipo_recurso_id: 3)
    Recurso.create!(id: 3, nombre: "Pagare", descripcion: "Documento Pagare", tipo_recurso_id: 1)
    Recurso.create!(id: 4, nombre: "Comprobante", descripcion: "Documento Comprobante", tipo_recurso_id: 1)
    Recurso.create!(id: 5, nombre: "Socios", descripcion: "Socio Catalogo", tipo_recurso_id: 2)
    Recurso.create!(id: 6, nombre: "ClientesMorosos", descripcion: "Informe Clientes Morosos", tipo_recurso_id: 4)
    Recurso.create!(id: 7, nombre: "ClientesCuotasVencidas", descripcion: "Informe Clientes Cuotas Vencidas", tipo_recurso_id: 4)
    Recurso.create!(id: 8, nombre: "ClientesNuevos", descripcion: "Informe Clientes Nuevos", tipo_recurso_id: 4)
    Recurso.create!(id: 9, nombre: "ExcedenPrestamos", descripcion: "Informe Clientes Exceden Prestamos", tipo_recurso_id: 4)
    Recurso.create!(id: 10, nombre: "Bancos", descripcion: "Catalogo Bancos", tipo_recurso_id: 2)
    Recurso.create!(id: 11, nombre: "FormasPago", descripcion: "Catalogo Formas de Pago", tipo_recurso_id: 2)
    Recurso.create!(id: 12, nombre: "Empresa", descripcion: "Catalogo Empresa", tipo_recurso_id: 2)
    Recurso.create!(id: 13, nombre: "Cargos", descripcion: "Catalogo Cargos", tipo_recurso_id: 2)
    Recurso.create!(id: 14, nombre: "TasaCambio", descripcion: "Catalogo TasaCambio", tipo_recurso_id: 2)
    Recurso.create!(id: 15, nombre: "ValorLeche", descripcion: "Catalogo Valor Leche", tipo_recurso_id: 2)
    Recurso.create!(id: 16, nombre: "Usuario", descripcion: "Configuración Usuarios", tipo_recurso_id: 5)
    Recurso.create!(id: 17, nombre: "Roles", descripcion: "Configuración Roles", tipo_recurso_id: 5)

    puts ': Realizado con exito.'

    puts '==> Creando Acciones por Defecto'
    Accion.create!(id: 1, nombre: "Lectura", descripcion: "Permite leer el recurso")
    Accion.create!(id: 2, nombre: "Escritura", descripcion: "Permite generar el recurso")
    Accion.create!(id: 3, nombre: "Actualizar", descripcion: "Permite actualizar el recurso")
    Accion.create!(id: 4, nombre: "Eliminar", descripcion: "Permite eliminar el recurso")
    puts ': Realizado con exito.'

    puts '==> Creando Usuarios por defecto'
    if Usuario.all.blank?
        Usuario.create!(email: 'admin@nicacentro.com', password: 'root12345',
                        password_confirmation: 'root12345', nombre: 'Administrador',
                        estado: true, roles_id: 1, posicions_id: 1  )
        Usuario.create!(email: 'gestorcobro@nicacentro.com', password: 'root12345',
            password_confirmation: 'root12345', nombre: 'Gestro de Cobro',
            estado: true, roles_id: 2, posicions_id: 2  )
        puts ': Realizado con exito.'
    else
        puts 'No se puede agregar datos por defecto a la tabla Usuarios, porque ya contiene registros'
    end
end