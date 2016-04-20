var data = {
  costs: [1.23, 1.10, 1.01, 2.99, 2.87, 2.77, 2.67, 2.65, 2.59, 2.47, 2.39],
  installs: [5.23, 5.10, 5.01, 4.99, 4.87, 4.77, 4.67, 4.65, 4.59, 4.47, 4.39],
  sizes: [5.23, 5.10, 5.01, 4.99, 4.87, 4.77, 4.67, 4.65, 4.59, 4.47, 4.39]
}

// if ($('.us').length !== 0) {
//   $.getJSON("http://localhost:3000/api/v1/summaries", function(data) {
//     updateCharts(data);
//   })
}

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
