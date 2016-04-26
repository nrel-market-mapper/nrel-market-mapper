if ($('.us').length !== 0) {
  $.getJSON("http://localhost:3000/api/v1/summaries.json", function(data) {
    updateData(data);
    loadUsMap($.parseJSON(data.geojson));
  })
}
