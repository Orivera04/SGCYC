const DINERO = 1,
      INTERCAMBIO = 2;
$(document).ready(function() {

    $("#forma_pagos_tipo_pago_id").change(function(event){
        let tipo_pago_id = $(event.target).val();

        if (tipo_pago_id == DINERO) {
            $("#dinero").removeClass("d-none");
            $("#intercambio").addClass("d-none");
        }
        else {
            $("#dinero").addClass("d-none");
            $("#intercambio").removeClass("d-none");
        }
    });

    $("#forma_pagos_tipo_pago_id").trigger("change");
});