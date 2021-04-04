$(document).ready(function() {
    // Montos Prestados
    new Chart(document.getElementById("montos_prestados"), {
        type: "bar",
        data: {
          labels: ["Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre",
                   "Enero", "Febrero", "Marzo", "Abril"],
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
                data: [2478,5267,734,784,433,2478,5267,734,784,433,332,433]
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
          labels: ["Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre",
                   "Enero", "Febrero", "Marzo", "Abril"],
          datasets: [
            {
                backgroundColor: [ "rgba(255, 99, 132, 0.2)"],
                borderColor: [ "rgba(255, 99, 132, 1)"],
                borderWidth: 3,
                label: "Abonos en los ultimos 12 meses",
                data: [2478,5267,734,784,433,2478,5267,734,784,433,332,433]
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
          labels: ["Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre",
                   "Enero", "Febrero", "Marzo", "Abril"],
          datasets: [
            {
                backgroundColor: [ "rgba(75, 192, 192, 0.5)"],
                borderColor: [ "rgba(75, 192, 192, 1)"],
                borderWidth: 3,
                fill: true,
                label: "Socios nuevos en los ultimos 12 meses",
                data: [2478,5267,734,784,433,2478,5267,734,784,433,332,433]
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