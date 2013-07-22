var App, CConsole, CLayout, ContentSide, Settings;

require('jquery');

require('cookie');

require('bootstrap');

require('underscore');

require('json2');

CConsole = require('CConsole');

CLayout = require('CLayout');

Settings = require('Settings');

ContentSide = require('ContentSide');

App = (function() {
  function App() {
    if (window.console == null) {
      window.console = new CConsole();
    }
    window.sn = new Settings();
    this.layout = new CLayout();
  }

  return App;

})();

$(function() {
  window.app = new App();
  return new ContentSide().render();
});
