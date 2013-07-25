var Backbone;

Backbone = require('Backbone');

module.exports = Backbone.Model.extend({
  defaults: {
    async: false,
    type: 'json',
    conf: {
      main: 'conf/main.json',
      themes: 'conf/themes.json',
      settings: 'conf/settings.json'
    },
    region: {
      caption: 'unknow',
      name: 'unknow'
    },
    theme: {
      caption: 'unknow',
      name: 'unknow'
    },
    settings: {
      paths: {}
    }
  },
  initialize: function() {
    this.main();
    this.theme();
    return this.settings();
  },
  main: function() {
    var _this;
    _this = this;
    return $.ajax({
      url: this.get('conf').main,
      async: this.get('async'),
      dataType: this.get('type'),
      success: function(s) {
        var region, theme;
        if (s != null) {
          console.log('conf: ' + 'main.json');
          region = _this.get('region');
          theme = _this.get('theme');
          if (s.region != null) {
            $.extend(region, s.region);
          }
          if (s.theme != null) {
            $.extend(theme, s.theme);
          }
          return _this.set({
            region: region,
            theme: theme
          });
        }
      }
    });
  },
  theme: function() {
    var _this;
    _this = this;
    return $.ajax({
      url: this.get('conf').themes,
      async: this.get('async'),
      dataType: this.get('type'),
      success: function(s) {
        var theme;
        if (s != null) {
          console.log('conf: ' + 'themes.json');
          theme = _this.get('theme');
          if (s[theme.name] != null) {
            $.extend(theme, s[theme.name]);
            return _this.set({
              theme: theme
            });
          }
        }
      }
    });
  },
  settings: function() {
    var _this;
    _this = this;
    return $.ajax({
      url: this.get('conf').settings,
      async: this.get('async'),
      dataType: this.get('type'),
      success: function(s) {
        var settings;
        if (s != null) {
          console.log('conf: ' + 'main.json');
          settings = _this.get('settings');
          if (s != null) {
            $.extend(settings, s);
          }
          return _this.set({
            settings: settings
          });
        }
      }
    });
  }
});
