google.charts.load('current', {'packages':['gauge']});
google.charts.setOnLoadCallback(drawChart);
google.charts.setOnLoadCallback(drawChart2);
google.charts.setOnLoadCallback(drawChart3);
const calorieElement = document.getElementById('chart_div');
const calorie = calorieElement.dataset.calories;
const carbElement = document.getElementById('chart_div2');
const carb = carbElement.dataset.carb;
const proteinElement = document.getElementById('chart_div3');
const protein = proteinElement.dataset.protein;


function drawChart() {

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

  var chart = new google.visualization.Gauge(document.getElementById('chart_div'));

  chart.draw(data, options);
};

function drawChart2() {

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

  var chart = new google.visualization.Gauge(document.getElementById('chart_div2'));

  chart.draw(data, options);
};

function drawChart3() {

  var data = google.visualization.arrayToDataTable([
    ['Label', 'Value'],
    ['Protein', Number(protein)],
  ]);

  var options = {
    width: 120, height: 120,
    greenFrom: 16, greenTo: 18,
    minorTicks: 2, min: 0, max: 18
  };

  var chart = new google.visualization.Gauge(document.getElementById('chart_div3'));

  chart.draw(data, options);
};
