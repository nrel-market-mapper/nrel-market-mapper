var costByYearCtx = document.getElementById('costByYear').getContext('2d');
var costByYearData = {
  type: 'line',
  data: {
    labels: ['2006', '2007', '2008', '2009', '2010', '2011', '2012', '2013', '2014', '2015', '2016'],
    datasets: [
      {
        label: 'Cost ($/W)',
        backgroundColor: 'rgba(11,103,191,.2)',
        borderColor: 'rgba(11,103,191,.44)',
        pointBorderWidth: 5,
        pointHoverRadius: 9,
        pointHoverBorderWidth: 4,
        data: [5.23, 5.10, 5.01, 4.99, 4.87, 4.77, 4.67, 4.65, 4.59, 4.47, 4.39]
      }
    ]
  }
};

var costByYearChart = new Chart(costByYearCtx, costByYearData);
