const Graph = React.createClass({
  componentDidMount() {
    let chart = this.loadChart(this.props.label, this.props.id);

    $.getJSON('/api/v1/summaries.json')
      .done(data => {
        this.updateData(data[this.props.graphName], chart);
      });
  },
  loadChart(label, id) {
    let DOMChart = document.getElementById(id).getContext('2d');
    let chartData = {
      type: 'line',
      data: {
        labels: ['2007', '2008', '2009', '2010', '2011', '2012', '2013', '2014', '2015', '2016'],
        datasets: [
          {
            label: label,
            backgroundColor: 'rgba(11,103,191,.2)',
            borderColor: 'rgba(11,103,191,.44)',
            pointBorderWidth: 5,
            pointHoverRadius: 9,
            pointHoverBorderWidth: 4,
            data: [10, 10, 10, 10, 10, 10, 10, 10, 10, 10]
          }
        ]
      }
    };

    return chart = new Chart(DOMChart, chartData);
  },
  updateData(data, chart) {
    data.forEach(function(point, index) {
      chart.data.datasets[0].data[index] = point;
    });
    chart.update();
  },
  render() {
    return (
      <canvas id={this.props.id} width="400" height="300"></canvas>
    );
  }
});
