const Graph = React.createClass({
  componentDidMount() {
    let chart = this.props.loadChart();
    $.getJSON('/api/v1/summaries.json')
      .done(data => {
        this.updateData(data[this.props.graphName], chart);
      });
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
