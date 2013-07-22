var App, CConsole, CLayout, Settings;

require('jquery');

require('cookie');

require('ejs');

require('bootstrap');

require('underscore');

require('json2');

CConsole = require('CConsole');

CLayout = require('CLayout');

Settings = require('Settings');

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
  return window.app = new App();
});
