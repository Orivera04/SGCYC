var formas_pagos;
$(document).ready(function() {
    $("#comprobante_socio_id").change(function(event) {
        let socio_id = $("#comprobante_socio_id").val();
        $.ajax({
            url: "obtener_pagare_socios",
            type: "get",
            data: {
              socio_id: socio_id
            },
            success: function(respuesta) {
                $("#comprobante_pagare_id").html(respuesta.lista).selectpicker('refresh').selectpicker('refresh');
                $("#comprobante_pagare_id").trigger("change");
            },
        });
    });

    $("#comprobante_pagare_id").change(function(event) {
        let pagare_id = $("#comprobante_pagare_id").val();
        $.ajax({
            url: "obtener_informacion_cuotas",
            type: "get",
            data: {
              pagare_id: pagare_id
            },
            success: function(respuesta) {
                $("#total_pendiente").text(respuesta.total_pendiente);
                $("#monto_cuota").text(respuesta.monto_cuota);
                $("#numero_cuota").text(respuesta.numero_cuota);
                $("#monto_pendiente").text(respuesta.monto_pendiente_cuota);
            },
        });
    });

    $("#agregar_fila").click(function(event) {
        let template = $("#template").clone(),
            contenedor = $("#detalle_pagos"),
            cantidad_detalles = $("#detalle_pagos > div").length;

        template.removeClass("invisible");
        template.find(".tipo_moneda_id").val("");
        template.find(".monto_input").val("0");
        template.find(".monto_convertido").val("0");
        template.find(".concepto_input").val("");

        var forma_pago_attr_name = template.find(".forma_pago_input").attr('name'),
            monto_attr_name = template.find(".monto_input").attr('name'),
            referencia_attr_name = template.find(".concepto_input").attr('name');

        template.find(".forma_pago_input").attr('name', forma_pago_attr_name.replace("0", cantidad_detalles));
        template.find(".monto_input").attr('name', monto_attr_name.replace("0", cantidad_detalles));
        template.find(".concepto_input").attr('name', referencia_attr_name.replace("0", cantidad_detalles));
        template.find(".forma_pago_input").prop("disabled", false);
        template.find(".monto_input").prop("disabled", false);;
        template.find(".concepto_input").prop("disabled", false);;
        contenedor.append(template);

        $(".forma_pago_input").change(function(event) {
            actualizarTotales();
        });

        $(".monto_input").change(function(event) {
            actualizarTotales();
        });

        $(".eliminar_fila").click(function(event) {
            $(event.target).closest(".fila").remove();
        });

        actualizarTotales();
    });

    $("#comprobante_socio_id").trigger("change");

    function actualizarTotales() {
        $.ajax({
            url: "obtener_totales",
            type: "get",
            data: {
                pagos: obtenerTotales()
            },
            success: function(respuesta) {
                formas_pagos = respuesta;
                $("#detalle_pagos > div").each(function(indice, elemento) {
                    $(elemento).find(".tipo_moneda_id").val(formas_pagos.pagos[indice].moneda);
                    $(elemento).find(".monto_convertido").val(formas_pagos.pagos[indice].monto_convertido);
                });

                $("#total_abonado").text(respuesta.total);
            },
        });
    }

    function obtenerTotales() {
        let lista_pagos = [];
        $("#detalle_pagos > div").each(function(indice, elemento) {
            lista_pagos.push({ forma_pago_id: $(elemento).find(".forma_pago_input").val(),
                               monto: $(elemento).find(".monto_input").val()
            })
        });

        return lista_pagos;
    }
});