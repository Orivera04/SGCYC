$(document).ready(function() {
    Swal.fire({
        title: 'Ingresa el valor de la leche del dia de hoy',
        input: 'text',
        inputPlaceholder: 'Valor',
        inputValidator: function(value) {
            return new Promise(function(resolve, reject) {
                if (value !== '') {
                    resolve();
                } else {
                    resolve('Es necesario que ingreses un valor');
                }
            });
        }
    }).then(function(resultado) {
        $.LoadingOverlay("show");
        if (resultado.isConfirmed) {
            $.ajax({
                url: "tasa_cambio_leche",
                type: "post",
                data: {
                    tasa_cambio: resultado.value
                },
                success: function(respuesta) {
                    $.LoadingOverlay("hide");
                    Swal.fire(
                        "Exito",
                        respuesta.mensaje,
                        "success"
                    )
                },
                error: function(respuesta) {
                    $.LoadingOverlay("hide");
                    Swal.fire(
                        "Error",
                        respuesta.mensaje,
                        "error"
                    )
                }
            })
        }
    });
});