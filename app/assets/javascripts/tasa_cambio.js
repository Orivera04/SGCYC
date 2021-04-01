$(document).ready(function() {

    // Eventos
    $('#tasa_cambio_modal').click(function(event) {
        Swal.fire({
            title: 'Selecciona el mes',
            input: 'select',
            inputOptions: {
              '1': 'Enero',
              '2': 'Febrero',
              '3': 'Marzo',
              '4': 'Abril',
              '5': 'Mayo',
              '6': 'Junio',
              '7': 'Julio',
              '8': 'Agosto',
              '9': 'Septiembre',
              '10': 'Octubre',
              '11': 'Noviembre',
              '12': 'Diciembre'
            },
            inputPlaceholder: 'Mes',
            inputValidator: function (value) {
              return new Promise(function (resolve, reject) {
                if (value !== '') {
                  resolve();
                } else {
                  resolve('Es necesario que selecciones un mes');
                }
              });
            }
          }).then(function (resultado) {
            $.LoadingOverlay("show");
            if (resultado.isConfirmed) {
                $.ajax({
                    url: "bcn_webservice",
                    type: "post",
                    data: {
                      mes: resultado.value
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
});