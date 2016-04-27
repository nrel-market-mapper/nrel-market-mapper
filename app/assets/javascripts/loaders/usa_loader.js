if ($('.us').length !== 0) {
  findDeviceWidth();

  $.getJSON("http://nrel-market-mapper.herokuapp.com/api/v1/summaries.json", function(data) {
    updateData(data);
    loadUsMap($.parseJSON(data.geojson));
  })
}
