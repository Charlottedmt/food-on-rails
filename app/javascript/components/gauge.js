function drawChart() {

  const chartDiv = document.getElementById('chart_div');
  if (chartDiv) {
    const calorie = chartDiv.dataset.calories;
    var data = google.visualization.arrayToDataTable([
      ['Label', 'Value'],
      ['Calories', Number(calorie)],
    ]);

    var options = {
      width: 120, height: 120,
      redFrom: 450, redTo: 500,
      yellowFrom:400, yellowTo: 450,
      minorTicks: 8, min: 0, max: 500
    };

    var chart = new google.visualization.Gauge(chartDiv);

    chart.draw(data, options);
    setInterval(function() {
          data.setValue(0, 1, Number(calorie) + Math.round(5 * Math.random()));
          chart.draw(data, options);
        }, 1000);
  };
};

function drawChart2() {
  const chartDiv2 = document.getElementById('chart_div2');
  if (chartDiv2) {
  const carb = chartDiv2.dataset.carb;

    var data = google.visualization.arrayToDataTable([
      ['Label', 'Value'],
      ['Carbs', Number(carb)],
    ]);

    var options = {
      width: 120, height: 120,
      redFrom: 100, redTo: 125,
      yellowFrom:90, yellowTo: 100,
      minorTicks: 8, min: 0, max: 125
    };

    var chart = new google.visualization.Gauge(chartDiv2);

    chart.draw(data, options);
    setInterval(function() {
          data.setValue(0, 1, Number(carb) + Math.round(1 * Math.random()));
          chart.draw(data, options);
        }, 1000);
  };
};

function drawChart3() {
  const chartDiv3 = document.getElementById('chart_div3');
  if (chartDiv3) {
    const protein = chartDiv3.dataset.protein;
    var data = google.visualization.arrayToDataTable([
      ['Label', 'Value'],
      ['Protein', Number(protein)],
    ]);

    var options = {
      width: 120, height: 120,
      greenFrom: 16, greenTo: 18,
      minorTicks: 2, min: 0, max: 18
    };

    var chart = new google.visualization.Gauge(chartDiv3);

    chart.draw(data, options);
    setInterval(function() {
          data.setValue(0, 1, Number(protein) + (1 * Math.random()));
          chart.draw(data, options);
        }, 2000);
  };
};

export { drawChart, drawChart2, drawChart3 }
