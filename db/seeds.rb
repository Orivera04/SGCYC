require 'base64'
begin
    puts '==> Creando Seeds'

    puts '==> Creando Empresa'
    Empresa.create!(id: 1, nombre_comercial: "NicaCentro", numero_telefono: "89438943",
                    correo: "admin@nicacentro.com", direccion: "Barrio 24 de Junio, del Puente Central 1 ½ cuadra al Este Matiguás Matagalpa",
                    actividad_comercial: "Cooperativa de Leche", numero_ruc: "J89342989", logo_imagen: Base64.encode64(File.open("#{Rails.root}/app/assets/images/logo_empresa_default.png", "rb").read))
    puts ': Realizado con exito.'

    puts '==> Creando Posiciones por defecto'
    Cargo.create!(id: 1, nombre: "Administrador del Sistema", descripcion: "Encargado de administrar el sistema")
    Cargo.create!(id: 2, nombre: "Gestor de Cobro", descripcion: "Encargado de realizar la cobranza")
    puts ': Realizado con exito.'

    puts '==> Creando Roles por defecto'
    Rol.create!(id: 1, nombre: "Administrador")
    Rol.create!(id: 2, nombre: "Gestor de cobro")
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

    puts '==> Creando Bancos por Defecto'
    Banco.create!(id: 1, nombre: "BAC Credomatic", siglas: "BAC")
    Banco.create!(id: 2, nombre: "Banco de Finanzas", siglas: "BDF")
    Banco.create!(id: 3, nombre: "Banco Ficohsa", siglas: "Ficohsa")
    Banco.create!(id: 4, nombre: "Banco Lafise Bancentro", siglas: "Lafise")
    Banco.create!(id: 5, nombre: "Banco de la Producción", siglas: "Banpro")
    Banco.create!(id: 6, nombre: "Banco Atlantida", siglas: "Atlantida")
    puts ': Realizado con exito.'

    puts '==> Creando Monedas por Defecto'
    TipoMoneda.create!(id: 1, nombre: "Cordoba", simbolo: "C$")
    TipoMoneda.create!(id: 2, nombre: "Dolar", simbolo: "USD")
    puts ': Realizado con exito.'

    puts '==> Creando Formas de pago por Defecto'
    FormaPago.create!(id: 1, nombre: "Efectivo", tipo_moneda_id: TipoMoneda::DOLAR)
    FormaPago.create!(id: 2, nombre: "Cheque", tipo_moneda_id: TipoMoneda::DOLAR )
    FormaPago.create!(id: 3, nombre: "Tarjeta", tipo_moneda_id: TipoMoneda::DOLAR )
    puts ': Realizado con exito.'

    puts '==> Creando Catalogo de Sexos por Defecto'
    Sexo.create!(id: 1, nombre: "Masculino")
    Sexo.create!(id: 2, nombre: "Femenino")
    puts ': Realizado con exito.'

    puts '==> Creando Catalogo de Escolaridades por Defecto'
    Escolaridad.create!(id: 1, nombre: "Primaria")
    Escolaridad.create!(id: 2, nombre: "Secundaria")
    Escolaridad.create!(id: 3, nombre: "Universidad")
    puts ': Realizado con exito.'

    puts '==> Creando Catalogo de Estados Civiles por Defecto'
    EstadoCivil.create!(id: 1, nombre: "Soltero")
    EstadoCivil.create!(id: 2, nombre: "Casado")
    EstadoCivil.create!(id: 3, nombre: "Viudo")
    puts ': Realizado con exito.'

    puts '==> Creando Catalogo de Tipos de Domicilio por Defecto'
    TipoDomicilio.create!(id: 1, nombre: "Propio")
    TipoDomicilio.create!(id: 2, nombre: "Alquilado")
    TipoDomicilio.create!(id: 3, nombre: "Familiar")
    puts ': Realizado con exito.'

    puts '==> Creando Socios Por Defecto'
    Socio.create!(id: 1, codigo_socio: "1", nombre: "Luis", apellido: "Rivera",
                  numero_cedula: "001-101197-0013X", fecha_nacimiento: "10/11/1997",
                  sexo_id: Sexo::MASCULINO, escolaridad_id: Escolaridad::UNIVERSIDAD,
                  profesion: "Desarollador de Software", estado_civil_id: EstadoCivil::SOLTERO,
                  anios_relacion: 0, numero_dependiente: 0, tipo_domicilio_id: TipoDomicilio::FAMILIAR,
                  numero_telefono: "87501549", direccion_domiciliar: "Barrio Venezuela", municipio: "Managua",
                  departamento: "Managua", empresa: "AG Software", numero_inss: "3920403904",
                  direccion_empresa: "Colonial Los Robles", departamento_empresa: "Managua",
                  municipio_empresa: "Managua", numero_telefono_empresa: "89438943", tiempo_laborar: "2 Años",
                  cargo: "Programador", salario_mensual: 15000, forma_pago: "Tarjeta", nombre_conyuge: "Emily Dayana",
                  apellido_conyuge: "Martinez Nuñez", numero_cedula_conyuge: "002-101097-0023X",
                  fecha_nacimiento_conyuge: "10-10-1997", ocupacion_conyuge: "Contador Publico", telefono_conyuge: "89328932",
                  lugar_trabajo_conyuge: "Celnicsa", tiempo_laborar_conyuge: "2", direccion_domicilio_conyuge: "Laureles Sur",
                  sexo_id_conyuge: Sexo::FEMENINO)
    Fiador.create!(id: 1, socio_id: 1, nombre: "Oscar", estado_civil_id: EstadoCivil::SOLTERO)
    Fiador.create!(id: 2, socio_id: 1, nombre: "Daniela", estado_civil_id: EstadoCivil::SOLTERO)
    puts ': Realizado con exito.'

    puts '==> Creando Catalogo de Plazos por Defecto'
    Plazo.create!(id: 1, nombre: "3 Meses", plazo: 3)
    Plazo.create!(id: 2, nombre: "6 Meses", plazo: 6)
    Plazo.create!(id: 3, nombre: "9 Meses", plazo: 9)
    Plazo.create!(id: 4, nombre: "12 Meses", plazo: 12)
    Plazo.create!(id: 5, nombre: "18 Meses", plazo: 18)
    Plazo.create!(id: 6, nombre: "24 Meses", plazo: 24)
    Plazo.create!(id: 7, nombre: "36 Meses", plazo: 36)
    Plazo.create!(id: 8, nombre: "48 Meses", plazo: 48)
    Plazo.create!(id: 9, nombre: "56 Meses", plazo: 56)
    Plazo.create!(id: 10, nombre: "72 Meses", plazo: 72)
    puts ': Realizado con exito.'

    puts '==> Creando Catalogo de Intereses por Defecto'
    Interes.create!(id: 1, cantidad: 7.5)
    Interes.create!(id: 2, cantidad: 8.5)
    Interes.create!(id: 3, cantidad: 9.5)
    Interes.create!(id: 4, cantidad: 10.5)
    Interes.create!(id: 5, cantidad: 11.5)
    Interes.create!(id: 6, cantidad: 12.5)
    Interes.create!(id: 7, cantidad: 13.5)
    puts ': Realizado con exito.'

    puts '==> Creando Usuarios por defecto'
    if Usuario.all.blank?
        Usuario.create!(email: 'admin@nicacentro.com', password: 'root12345',
                        password_confirmation: 'root12345', nombre: 'Administrador',
                        activo: true, rols_id: 1, cargos_id: 1  )
        Usuario.create!(email: 'gestorcobro@nicacentro.com', password: 'root12345',
            password_confirmation: 'root12345', nombre: 'Gestro de Cobro',
            activo: true, rols_id: 2, cargos_id: 2  )
        puts ': Realizado con exito.'
    else
        puts 'No se puede agregar datos por defecto a la tabla Usuarios, porque ya contiene registros'
    end
end