const Usa = React.createClass({
  getInitialState() {
    return {
      totals: {},
    };
  },
  componentWillMount() {
    this.findDeviceWidth();
  },
  componentDidMount() {
    $.getJSON('/api/v1/summaries.json')
      .done(data => this.setState({ totals: data.totals }));
  },
  findDeviceWidth() {
    let deviceWidth = $(window).width();

    if (deviceWidth >= 768) {
      Chart.defaults.global.defaultFontSize = 28;
    }
  },
  render() {
    let totals = this.state.totals;

    return (
      <div>
        <div className="container box-map clearfix">
          <div className="callout-boxes">
            <div className="row">
              <CalloutBox title="# of Installs" data={totals.installs} />
              <CalloutBox title="Capacity (MW)" data={totals.capacity} />
              <CalloutBox title="Avg Cost" data={totals.cost} />
            </div>
          </div>

          <div className="map">
            <Map />
          </div>
        </div>

        <section className="us container">
          <Graph id="installs"
                 graphName="installs"
                 label="Number of Installs" />
          <Graph id="size"
                 graphName="capacities"
                 label="Capacity (MW)" />
          <Graph id="costByYear"
                 graphName="costs"
                 label="Cost ($/W)" />
        </section>
      </div>
    );
  }
});
