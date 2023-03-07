var window = Window.find("palette", "Pasting Buddy");
if (window && window.visible) {
  var pauseButton = window.find("pauseButton");
  pauseButton.onClick();
}
