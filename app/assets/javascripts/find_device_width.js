function findDeviceWidth() {
  var deviceWidth = $(window).width();

  if (deviceWidth >= 768) {
    Chart.defaults.global.defaultFontSize = 28;
  }
}
