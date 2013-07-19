var snApp, snConf, snDesign, snEvents, snLayout, snModels, snTriggers;

require('jquery');

require('cookie');

require('bootstrap');

snConf = require('conf');

snDesign = require('design');

snModels = require('models');

snLayout = require('layout');

snTriggers = require('triggers');

snEvents = require('events');

if (window.console == null) {
  window.console = {
    info: function() {},
    log: function() {},
    error: function() {},
    warn: function() {}
  };
}

snApp = (function() {
  function snApp(options) {
    this.options = options != null ? options : {};
    this.setup();
    this.start();
  }

  snApp.prototype.setup = function() {
    window.sn = {
      region: {
        caption: 'unknow',
        name: 'unknow'
      },
      theme: {
        caption: 'unknow',
        name: 'unknow'
      }
    };
    window.conf = new snConf();
    window.design = new snDesign();
    window.models = new snModels();
    window.layout = new snLayout();
    window.triggers = new snTriggers();
    return window.events = new snEvents();
  };

  snApp.prototype.start = function() {
    console.log('autoload...');
    return window.events.get('#autoload');
  };

  return snApp;

})();

$(function() {
  return window.app = new snApp();
});
