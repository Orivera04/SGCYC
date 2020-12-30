begin
    puts '==> Creando Usuarios por defecto'
    if Usuario.all.blank?
        Usuario.create!(email: 'admin@nicacentro.com', password: 'root12345',
                        password_confirmation: 'root12345', nombre: 'admin',
                        estado: true)
        puts ': Realizado con exito.'
    else
        puts 'No se puede agregar datos por defecto a la tabla Usuarios, porque ya contiene registros'
    end
end