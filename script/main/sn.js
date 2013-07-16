require('jquery');

require('cookie');

require('bootstrap');

require('conf');

require('design');

require('models');

require('layout');

require('triggers');

require('events');

$(function() {
  if (window.console == null) {
    window.console = {
      info: function() {},
      log: function() {},
      error: function() {},
      warn: function() {}
    };
  }
  window.snApp = (function() {
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
  return window.app = new snApp();
});
