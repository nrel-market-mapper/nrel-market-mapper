var $stateSelect = $('#states');
$stateSelect.on('change', function() {
  var state = $stateSelect.val();

  $.getJSON("http://localhost:3000/api/v1/summaries/find?state=" + state, function(data) {
    updateCharts(data);
  })
});

function updateCharts(data) {
  updateCosts(data.costs);
  updateInstalls(data.installs);
  updateSizes(data.sizes);
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

function updateSizes(sizes) {
  sizes.forEach(function(size, index) {
    sizeChart.data.datasets[0].data[index] = size;
  });
  sizeChart.update();
}
