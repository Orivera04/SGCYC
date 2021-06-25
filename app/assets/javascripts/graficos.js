$(document).ready(function() {
    let meses = JSON.parse($("#meses").val()),
        montos_prestados = JSON.parse($("#montos_prestados_grafico").val()),
        total_abonos = JSON.parse($("#total_abonos_grafico").val()),
        clientes_nuevos = JSON.parse($("#clientes_nuevos_grafico").val());

    // Montos Prestados
    new Chart(document.getElementById("montos_prestados"), {
        type: "bar",
        data: {
          labels: meses,
          datasets: [
            {
                backgroundColor: [
                    'rgba(255, 99, 132, 0.5)',
                    'rgba(54, 162, 235, 0.5)',
                    'rgba(255, 206, 86, 0.5)',
                    'rgba(75, 192, 192, 0.5)',
                    'rgba(153, 102, 255, 0.5)',
                    'rgba(255, 159, 64, 0.5)'
                ],
                borderColor: [
                    'rgba(255,99,132,1)',
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)',
                    'rgba(255, 159, 64, 1)'
                ],
                borderWidth: 1,
                label: "Montos prestados en los ultimos 12 Meses",
                data: montos_prestados
            }
          ]
        },
        options: {
            responsive: true,
            legend: {
              display: false
            }
        }
    });

    // Total Abonos
    new Chart(document.getElementById("total_abonos"), {
        type: "line",
        data: {
          labels: meses,
          datasets: [
            {
                backgroundColor: [ "rgba(255, 99, 132, 0.2)"],
                borderColor: [ "rgba(255, 99, 132, 1)"],
                borderWidth: 3,
                label: "Abonos en los ultimos 12 meses",
                data: total_abonos
            }
          ]
        },
        options: {
            responsive: true,
            legend: {
              display: false
            }
        }
    });
    // Socios Nuevos
    new Chart(document.getElementById("socios_nuevos"), {
        type: "line",
        data: {
          labels: meses,
          datasets: [
            {
                backgroundColor: [ "rgba(75, 192, 192, 0.5)"],
                borderColor: [ "rgba(75, 192, 192, 1)"],
                borderWidth: 3,
                fill: true,
                label: "Socios nuevos en los ultimos 12 meses",
                data: clientes_nuevos
            }
          ]
        },
        options: {
            responsive: true,
            legend: {
              display: false
            },
            maintainAspectRatio: false,
        }
    });
});