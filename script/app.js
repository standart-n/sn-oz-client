var App, Backbone, CConsole, CLayout, ContentPrimary, ContentSide, Router, Settings;

require('jquery');

require('cookie');

require('bootstrap');

require('json2');

Backbone = require('backbone');

CConsole = require('CConsole');

Settings = require('Settings');

CLayout = require('CLayout');

ContentSide = require('ContentSide');

ContentPrimary = require('ContentPrimary');

Router = require('Text');

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
  var router;
  window.app = new App();
  new ContentSide().render();
  new ContentPrimary().render();
  router = new Router();
  return Backbone.history.start();
});
