$(document).ready(function() {
  debugger;
  $("input:submit").click(function( event ) {
    if ($("form").attr('method') == "get") {
      return;
    }

    Swal.fire({
      title: "¿Seguro que quieres guardar?",
      showDenyButton: true,
      confirmButtonText: "Guardar"
    }).then((result) => {
      if (result.isConfirmed) {
        $("form").first().submit();
      }
    });
    event.preventDefault();
  });


});