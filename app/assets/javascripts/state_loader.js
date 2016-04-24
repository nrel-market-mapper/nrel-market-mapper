if ($('.states').length !== 0) {
  var $stateSelect = $('#states');
  $stateSelect.on('change', function() {
    var state = $stateSelect.val();

    $.getJSON("http://localhost:3000/api/v1/summaries/find?state=" + state, function(data) {
      updateCharts(data);
      var parsedGeoJson = $.parseJSON(data.geojson);
      loadMap(parsedGeoJson);
    })
  });

  function updateCharts(data) {
    updateCosts(data.costs);
    updateInstalls(data.installs);
    updateSizes(data.capacities);
    updateTotals(data.totals);
  }

  function updateCosts(costs) {
    costs.forEach(function(cost, index) {
      costByYearChart.data.datasets[0].data[index] = cost;
    });
    costByYearChart.update();
  }

  function updateInstalls(installs) {
    installs.forEach(function(install, index){
      installsChart.data.datasets[0].data[index] = install;
    });
    installsChart.update();
  }

  function updateSizes(sizes) {
    sizes.forEach(function(size, index) {
      sizeChart.data.datasets[0].data[index] = size;
    });
    sizeChart.update();
  }

  function updateTotals(totals) {
    $(".installs h4").html(totals.installs);
    $(".capacity h4").html(totals.capacity);
    $(".cost h4").html(totals.cost);
  }

  function loadMap(geojson) {
    var mymap = L.map('map').setView([39.1, -105.5], 6);
    var lastClickedLayer = null;

    L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', {
        id: 'mapbox.light',
        accessToken: 'pk.eyJ1IjoianVsc2ZlbGljIiwiYSI6ImNpbmFmaHlnazBobjZ2MGt2aWltcHN5ZWIifQ.dXiLrMR-naZgZVExDlTlcA'
    }).addTo(mymap);

    function getColor(d) {
      return d > 10000 ? '#08589e' :
             d > 3000  ? '#2b8cbe' :
             d > 1000  ? '#4eb3d3' :
             d > 500   ? '#7bccc4' :
             d > 100   ? '#a8ddb5' :
                         '#ccebc5'
    }

    function style(feature) {
      return {
        fillColor: getColor(feature.properties.installs),
        weight: 2,
        opacity: 1,
        color: 'white',
        dashArray: '3',
        fillOpacity: 0.7
      };
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
      this._div.innerHTML = '<h4>State Solar Installations</h4>' + (props ?
          '<b>' + props.name + '</b><br>' + props.installs + ' installs' : 'Click on a county');
    };

    var legend = L.control({position: 'bottomright'});

    legend.onAdd = function(map) {
      var div = L.DomUtil.create('div', 'info legend'),
          grades = [0, 100, 500, 1000, 3000, 10000],
          labels = [];

      // loop through our density intervals and generate a label with a colored square for each interval
      for (var i = 0; i < grades.length; i++) {
          div.innerHTML +=
              '<i style="background:' + getColor(grades[i] + 1) + '"></i> ' +
              grades[i] + (grades[i + 1] ? '&ndash;' + grades[i + 1] + '<br>' : '+');
      }

      return div;
    }

    var geojson = L.geoJson(geojson, {
      style: style,
      onEachFeature: onEachFeature
    }).addTo(mymap);

    info.addTo(mymap);
    legend.addTo(mymap);
  }
}
