var size = document.getElementById('size').getContext('2d');
var sizeData = {
  type: 'line',
  data: {
    labels: ['2007', '2008', '2009', '2010', '2011', '2012', '2013', '2014', '2015', '2016'],
    datasets: [
      {
        label: 'Capacity (MW)',
        pointBorderWidth: 5,
        pointHoverRadius: 9,
        pointHoverBorderWidth: 4,
        data: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
      }
    ]
  }
};

var sizeChart = new Chart(size, sizeData);
