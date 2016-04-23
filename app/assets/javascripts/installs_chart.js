var installs = document.getElementById('installs').getContext('2d');
var installsData = {
  type: 'line',
  data: {
    labels: ['2007', '2008', '2009', '2010', '2011', '2012', '2013', '2014', '2015', '2016'],
    datasets: [
      {
        label: 'Number of Installs',
        backgroundColor: 'rgba(11,103,191,.2)',
        borderColor: 'rgba(11,103,191,.44)',
        pointBorderWidth: 5,
        pointHoverRadius: 9,
        pointHoverBorderWidth: 4,
        data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
      }
    ]
  }
};

var installsChart = new Chart(installs, installsData);
