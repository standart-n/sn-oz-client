require('jquery');

require('ejs');

$(function() {
  return window.snModels = (function() {
    function snModels(options) {
      this.options = options != null ? options : {};
    }

    snModels.prototype.get = function(elem, options) {
      var def;
      if (elem == null) {
        elem = '#main';
      }
      if (options == null) {
        options = {};
      }
      console.log('models into ' + elem);
      def = {
        wiki: true
      };
      $.extend(def, options);
      def.elem = elem;
      return this.append(def);
    };

    snModels.prototype.append = function(def) {
      var _this = this;
      if (def == null) {
        def = {};
      }
      if (def.file != null) {
        return this.load(def.file, function(s) {
          def.text = s;
          return _this.inner(def);
        });
      } else {
        if (def.text != null) {
          return this.inner(def);
        } else {
          if (def.view != null) {
            if (window.EJS != null) {
              def.text = new EJS({
                url: 'view/' + def.view,
                ext: '.html'
              }).render(window.sn);
              return this.inner(def);
            }
          } else {
            if (def.layout != null) {
              if (window.EJS != null) {
                def.text = new EJS({
                  url: 'layout/' + window.sn.region.name + '/' + def.layout,
                  ext: '.html'
                }).render(window.sn);
                return this.inner(def);
              }
            }
          }
        }
      }
    };

    snModels.prototype.inner = function(options) {
      var def;
      if (options == null) {
        options = {};
      }
      def = {
        elem: '#main',
        wiki: true,
        position: 'place'
      };
      $.extend(def, options);
      if (def.text != null) {
        console.log('innerText');
        if (def.wiki === true && (window.wiki != null)) {
          def.text = window.wiki.render(def.text);
        }
        switch (def.position) {
          case 'place':
            return $(def.elem).html(def.text);
          case 'after':
            return $(def.elem).html($(def.elem).html() + def.text);
          case 'before':
            return $(def.elem).html(def.text + $(def.elem).html());
        }
      }
    };

    snModels.prototype.load = function(file, callback) {
      var url;
      if (file != null) {
        url = 'content/' + window.sn.region.name + '/' + file;
        console.log('file: ' + file);
        return $.ajax({
          url: url,
          async: false,
          cache: false,
          dataType: 'html',
          success: function(text) {
            if (text != null) {
              console.log('success');
              if (callback) {
                return callback(text);
              }
            }
          }
        });
      }
    };

    return snModels;

  })();
});
