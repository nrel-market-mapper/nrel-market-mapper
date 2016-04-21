if ($('.us').length !== 0) {
  $.getJSON("http://localhost:3000/api/v1/summaries.json", function(data) {
    updateCharts(data);
  })
}

function updateCharts(data) {
  updateCosts(data.costs);
  updateInstalls(data.installs);
  updateCapacities(data.capacities);
  updateTotals(data.totals)
}

function updateCosts(costs) {
  costs.forEach(function(cost, index) {
    costByYearChart.data.datasets[0].data[index] = cost;
  });
  costByYearChart.update();
}

function updateInstalls(installs) {
  installs.forEach(function(install, index){
    installsChart.data.datasets[0].data[index] = install;
  });
  installsChart.update();
}

function updateCapacities(sizes) {
  sizes.forEach(function(size, index) {
    sizeChart.data.datasets[0].data[index] = size;
  });
  sizeChart.update();
}

function updateTotals(totals) {
  $(".installs h4").html(totals.installs);
  $(".capacity h4").html(totals.capacity);
  $(".cost h4").html(totals.cost);
}
