var Backbone;

Backbone = require('backbone');

module.exports = Backbone.Model.extend({
  defaults: {
    async: false,
    type: 'json',
    conf: {
      main: 'conf/main.json',
      themes: 'conf/themes.json'
    },
    region: {
      caption: 'unknow',
      name: 'unknow'
    },
    theme: {
      caption: 'unknow',
      name: 'unknow'
    }
  },
  initialize: function() {
    this.main();
    return this.theme();
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
  }
});
