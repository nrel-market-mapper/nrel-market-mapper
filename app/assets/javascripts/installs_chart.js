var installs = document.getElementById('installs').getContext('2d');
var installsData = {
  type: 'line',
  data: {
    labels: ['2006', '2007', '2008', '2009', '2010', '2011', '2012', '2013', '2014', '2015', '2016'],
    datasets: [
      {
        label: 'Installs',
        pointBorderWidth: 5,
        pointHoverRadius: 9,
        pointHoverBorderWidth: 4,
        data: [100, 400, 900, 2400, 4900, 7200, 16000, 17000, 26000, 37000, 32000]
      }
    ]
  }
};

var installsChart = new Chart(installs, installsData);
