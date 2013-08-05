var App, Authorization, Backbone, Markup, Settings, Social;

require('jquery');

require('cookie');

require('bootstrap');

require('json2');

Backbone = require('Backbone');

App = require('App');

Authorization = require('Authorization');

Social = require('Social');

Settings = require('Settings');

Markup = require('Markup');

if (window.console == null) {
  window.console = {
    info: function() {},
    log: function() {},
    error: function() {},
    warn: function() {}
  };
}

$(function() {
  Backbone.emulateHTTP = true;
  Backbone.emulateJSON = true;
  window.sn = new Settings();
  window.markup = new Markup({
    images: {
      url: window.sn.get('settings').paths.images.url + window.sn.get('region').name + '/'
    },
    files: {
      url: window.sn.get('settings').paths.files.url + window.sn.get('region').name + '/'
    },
    gismeteo: {
      url: window.sn.get('settings').paths.widgets.gismeteo.url + window.sn.get('region').name + '/'
    }
  });
  window.app = new App();
  window.authorization = new Authorization();
  window.social = new Social();
  return Backbone.history.start();
});
