const Map = React.createClass({
  componentDidMount() {
    $.getJSON('/api/v1/summaries.json')
      .done(data => loadUsMap($.parseJSON(data.geojson)));
  },
  render() {
    return (
      <div id="map" style={{ height: 300 + 'px' }}></div>
    );
  }
});
