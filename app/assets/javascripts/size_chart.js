var size = document.getElementById('size').getContext('2d');
var sizeData = {
  type: 'line',
  data: {
    labels: ['2006', '2007', '2008', '2009', '2010', '2011', '2012', '2013', '2014', '2015', '2016'],
    datasets: [
      {
        backgroundColor: 'rgba(11,103,191,.2)',
        borderColor: 'rgba(11,103,191,.44)',
        label: 'Size (MW)',
        pointBorderWidth: 5,
        pointHoverRadius: 9,
        pointHoverBorderWidth: 4,
        data: [10, 10, 14, 20, 35, 200, 220, 400, 800, 1100, 820]
      }
    ]
  }
};

var sizeChart = new Chart(size, sizeData);
