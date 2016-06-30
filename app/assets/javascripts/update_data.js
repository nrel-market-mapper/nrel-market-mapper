function updateData(data) {
  updateCosts(data.costs);
  updateInstalls(data.installs);
  updateCapacities(data.capacities);
  updateTotals(data.totals)
}

function updateCosts(costs, chart) {
  costs.forEach(function(cost, index) {
    chart.data.datasets[0].data[index] = cost;
  });
  chart.update();
}

function updateInstalls(installs, chart) {
  installs.forEach(function(install, index){
    chart.data.datasets[0].data[index] = install;
  });
  chart.update();
}

function updateCapacities(sizes, chart) {
  sizes.forEach(function(size, index) {
    chart.data.datasets[0].data[index] = size;
  });
  chart.update();
}

function updateTotals(totals) {
  $(".installs h4").html(totals.installs);
  $(".capacity h4").html(totals.capacity);
  $(".cost h4").html(totals.cost);
}
