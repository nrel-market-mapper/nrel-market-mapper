const Usa = React.createClass({
  getInitialState() {
    return {
      capacities: [],
      costs: [],
      installs: [],
      totals: {},
      years: [],
    };
  },
  componentWillMount() {
    this.findDeviceWidth();
  },
  componentDidMount() {
    $.getJSON('/api/v1/summaries.json')
      .done(data => this.setState({
        capacities: data.capacities,
        costs: data.costs,
        installs: data.installs,
        totals: data.totals,
        years: data.years
      }));
  },
  findDeviceWidth() {
    let deviceWidth = $(window).width();

    if (deviceWidth >= 768) {
      Chart.defaults.global.defaultFontSize = 28;
    }
  },
  render() {
    return (
      <div>
        <div className="container box-map clearfix">
          <div>

          </div>
          <div className="callout-boxes">
            <div className="row">
              <CalloutBox title="# of Installs" data={this.state.totals.installs} />
              <CalloutBox title="Capacity (MW)" data={this.state.totals.capacity} />
              <CalloutBox title="Avg Cost" data={this.state.totals.cost} />
            </div>
          </div>

          <div className="map">
            <Map />
          </div>
        </div>
        <section className="us container">
          <Graph id="installs"
                 graphName="installs"
                 loadChart={loadInstallsChart}
                 updateData={updateInstalls} />
          <Graph id="size"
                 graphName="capacities"
                 loadChart={loadSizeChart}
                 updateData={updateCapacities} />
          <Graph id="costByYear"
                 graphName="costs"
                 loadChart={loadCostByYearChart}
                 updateData={updateCosts} />
        </section>
      </div>
    );
  }
});
