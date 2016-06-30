const Graph = React.createClass({
  componentDidMount() {
    let chart = this.props.loadChart();
    $.getJSON('/api/v1/summaries.json')
      .done(data => {
        this.props.updateData(data[this.props.graphName], chart);
      });
  },
  render() {
    return (
      <canvas id={this.props.id} width="400" height="300"></canvas>
    );
  }
});
