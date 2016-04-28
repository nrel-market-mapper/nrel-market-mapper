function loadStateMap(geojson, data) {
  var
    stateInfo = {
      maxCountyInstalls: data.max_county_installs,
      defaultColor: '#ccebc5',
      defaultStyle: {
        weight: 2,
        opacity: 1,
        color: 'white',
        dashArray: '3',
        fillOpacity: 0.7
      },
      dataSetHi: [
        { level: data.max_county_installs * 0.5,  color: '#08589e' },
        { level: data.max_county_installs * 0.3,  color: '#2b8cbe' },
        { level: data.max_county_installs * 0.1,  color: '#4eb3d3' },
        { level: data.max_county_installs * 0.06, color: '#7bccc4' },
        { level: data.max_county_installs * 0.03, color: '#a8ddb5' }
      ],
      dataSetLow: [
        { level: 10, color: '#08589e' },
        { level: 8,  color: '#2b8cbe' },
        { level: 6,  color: '#4eb3d3' },
        { level: 4,  color: '#7bccc4' },
        { level: 2,  color: '#a8ddb5' }
      ]
    };
  mymap = L.map('map').setView(data.lat_long, data.zoom);
  var lastClickedLayer = null;

  L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', {
      id: 'mapbox.light',
      accessToken: 'pk.eyJ1IjoianVsc2ZlbGljIiwiYSI6ImNpbmFmaHlnazBobjZ2MGt2aWltcHN5ZWIifQ.dXiLrMR-naZgZVExDlTlcA'
  }).addTo(mymap);

  function getColor(d, dataset) {
    for (var i=0; i<dataset.length; i++) {
      if (d >= dataset[i].level) { return dataset[i].color; }
    }
    return stateInfo.defaultColor;
  }

  function getStyle(feature) {
    var dataset = stateInfo.maxCountyInstalls < 30 ? stateInfo.dataSetLow : stateInfo.dataSetHi;
    return _.extend(stateInfo.defaultStyle, {
      fillColor: getColor(feature.properties.installs, dataset)
    });
  }

  var geojson;

  function highlightFeature(e) {
    if (lastClickedLayer !== null) {
      geojson.resetStyle(lastClickedLayer);
    }
    var layer = e.target;

    layer.setStyle({
      weight: 5,
      color: '#666',
      dashArray: '',
      fillOpacity: 0.7
    });

    if (!L.Browser.ie && !L.Browser.opera) {
      layer.bringToFront();
    }

    info.update(layer.feature.properties);
    lastClickedLayer = e.target;
  }

  function resetHighlight(e) {
    geojson.resetStyle(e.target);
    info.update();
  }

  function zoomToFeature(e) {
    mymap.fitBounds(e.target.getBounds());
  }

  function onEachFeature(feature, layer) {
    layer.on({
      mouseover: highlightFeature,
      mouseout: resetHighlight,
      click: highlightFeature
    });
  }

  var info = L.control();

  info.onAdd = function(map) {
    this._div = L.DomUtil.create('div', 'info'); // create a div with a class of info
    this.update();
    return this._div;
  };

  // method that we will use to update the control based on feature properties passed
  info.update = function(props) {
    this._div.innerHTML = '<h4>' + state + ' Solar Installations</h4>' + (props ?
        '<b>' + props.name + '</b><br>' + props.installs + ' installs' : 'Click on a county');
  };

  var legend = L.control({position: 'bottomright'});

  function createLegend() {
    var
      dataset = stateInfo.maxCountyInstalls < 30 ? stateInfo.dataSetLow : stateInfo.dataSetHi,
      legendSet = _.map(_.reverse(_.clone(dataset)), function (setObject) {
        return parseInt(setObject.level);
      });
    legendSet.unshift(0);
    return legendSet;
  };

  var getLegendColor = ['#ccebc5', '#a8ddb5', '#7bccc4', '#4eb3d3', '#2b8cbe', '#08589e']

  legend.onAdd = function(map) {
    var div = L.DomUtil.create('div', 'info legend'),
      grades = createLegend();
      labels = [];

    // loop through our density intervals and generate a label with a colored square for each interval
    for (var i = 0; i < grades.length; i++) {
        div.innerHTML +=
            '<i style="background:' + getLegendColor[i] + '"></i> ' +
            grades[i] + (grades[i + 1] ? '&ndash;' + grades[i + 1] + '<br>' : '+');
    }

    return div;
  }

  var geojson = L.geoJson(geojson, {
    style: getStyle,
    onEachFeature: onEachFeature
  }).addTo(mymap);

  info.addTo(mymap);
  legend.addTo(mymap);
}
