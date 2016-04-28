function changeInfoText(text) {
  var deviceWidth = $(window).width();
  clickOrHover = "Click on a " + text;

  if (deviceWidth >= 768) {
    clickOrHover = "Hover on a " + text;
  }
}
