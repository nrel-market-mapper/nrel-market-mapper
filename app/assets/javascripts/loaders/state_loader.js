// if ($('.states').length !== 0) {
//   findDeviceWidth();
//
//   var mymap;
//   var $stateSelect = $('#states');
//
//   $(document).on('ready', function() {
//     loadBlankMap();
//   });
//
//   $stateSelect.on('change', function() {
//     state = $stateSelect.val();
//     mymap.remove();
//
//     $.getJSON("/api/v1/summaries/find?state=" + state, function(data) {
//       updateData(data);
//       loadStateMap($.parseJSON(data.geojson), data);
//     })
//   });
// }
