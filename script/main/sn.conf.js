var snConf, snWiki;

require('jquery');

snWiki = require('wiki');

module.exports = snConf = (function() {
  function snConf(options) {
    this.options = options != null ? options : {};
    this.main();
    this.theme();
    this.css();
    this.js();
    this.settings();
    this.wiki();
  }

  snConf.prototype.main = function() {
    return $.ajax({
      url: 'conf/main.json',
      async: false,
      dataType: 'json',
      success: function(s) {
        if (s != null) {
          console.log('conf: ' + 'main.json');
          if ((s.region != null) && (s.theme != null)) {
            return $.extend(window.sn, s);
          }
        }
      }
    });
  };

  snConf.prototype.theme = function() {
    return $.ajax({
      url: 'conf/themes.json',
      async: false,
      dataType: 'json',
      success: function(s) {
        if (s != null) {
          console.log('conf: ' + 'themes.json');
          if (s[window.sn.theme.name] != null) {
            return $.extend(window.sn.theme, s[window.sn.theme.name]);
          }
        }
      }
    });
  };

  snConf.prototype.css = function() {
    console.log('conf: ' + 'css');
    if (window.sn.theme.css != null) {
      return $.each(window.sn.theme.css, function(i) {
        var head, link;
        head = document.getElementsByTagName('head')[0];
        link = document.createElement('link');
        link.rel = 'stylesheet';
        link.type = 'text/css';
        link.href = this;
        return head.appendChild(link);
      });
    }
  };

  snConf.prototype.js = function() {
    console.log('conf: ' + 'js');
    if (window.sn.theme.js != null) {
      return $.each(window.sn.theme.js, function(i) {
        return $.getScript(this);
      });
    }
  };

  snConf.prototype.settings = function() {
    return $.ajax({
      url: 'conf/settings.json',
      async: false,
      dataType: 'json',
      success: function(s) {
        if (s != null) {
          console.log('conf: ' + 'settings.json');
          return window.sn.settings = s;
        }
      }
    });
  };

  snConf.prototype.wiki = function() {
    return window.wiki = new snWiki({
      images: {
        url: window.sn.settings.paths.images.url + sn.region.name + '/'
      },
      files: {
        url: window.sn.settings.paths.files.url + sn.region.name + '/'
      },
      gismeteo: {
        url: window.sn.settings.paths.widgets.gismeteo.url + sn.region.name + '/'
      }
    });
  };

  return snConf;

})();
