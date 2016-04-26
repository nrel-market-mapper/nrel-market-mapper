function loadBlankMap() {
  mymap = L.map('map').setView([37.8, -96], 3);

  L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', {
      id: 'mapbox.light',
      accessToken: 'pk.eyJ1IjoianVsc2ZlbGljIiwiYSI6ImNpbmFmaHlnazBobjZ2MGt2aWltcHN5ZWIifQ.dXiLrMR-naZgZVExDlTlcA'
  }).addTo(mymap);
}
