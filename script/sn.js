/*
Старт приложения
----------------
*/


(function() {
  $(function() {
    var $this;
    if (window.console == null) {
      window.console = {
        info: function() {},
        log: function() {},
        error: function() {},
        warn: function() {}
      };
    }
    $this = {
      init: function(options) {
        if (options == null) {
          options = {};
        }
        $(this).sn('setup', options);
        return $(this).sn('start');
      },
      setup: function(options) {
        var sn;
        if (options == null) {
          options = {};
        }
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
        sn = {
          levels: {},
          users: {},
          content: {},
          conf: {},
          result: {},
          theme: {},
          settings: {}
        };
        $.extend(true, sn, options);
        $(this).data('sn', sn);
        return sn;
      },
      start: function(options) {
        if (options == null) {
          options = {};
        }
        console.log('configuration...');
        $(this).snConf();
        console.log('layout...');
        $(this).snLayout();
        console.log('autoload...');
        return $(this).snEvents('#autoload');
      }
    };
    return $.fn.sn = function(sn) {
      if (sn == null) {
        sn = {};
      }
      if ($this[sn]) {
        return $this[sn].apply(this, Array.prototype.slice.call(arguments, 1));
      } else {
        return $this.init.apply(this, arguments);
      }
    };
  });

}).call(this);

/*
Загрузка настроек
-----------------
*/


(function() {
  $(function() {
    var $this;
    $this = {
      init: function(options) {
        if (options == null) {
          options = {};
        }
        $(this).snConf('main');
        $(this).snConf('theme');
        $(this).snConf('css');
        $(this).snConf('js');
        $(this).snConf('settings');
        return $(this).snConf('wiki');
      },
      main: function() {
        var sn;
        sn = $(this).data('sn');
        console.log('conf: ' + 'main.json');
        return $.ajax({
          url: 'conf/main.json',
          async: false,
          dataType: 'json',
          success: function(s) {
            if (s != null) {
              $.extend(sn, s);
              sn.conf.main = true;
            }
            if (sn.region != null) {
              window.sn.region = sn.region;
            }
            if (sn.theme != null) {
              window.sn.theme = sn.theme;
            }
            return $(this).data('sn', sn);
          }
        });
      },
      theme: function() {
        var sn;
        sn = $(this).data('sn');
        console.log('conf: ' + 'themes.json');
        return $.ajax({
          url: 'conf/themes.json',
          async: false,
          dataType: 'json',
          success: function(s) {
            if (s != null) {
              sn.conf.theme = true;
              if (s[sn.theme.name] != null) {
                $.extend(sn.theme, s[sn.theme.name]);
                sn.theme.enable = true;
              } else {
                sn.theme.enable = false;
              }
              return $(this).data('sn', sn);
            }
          }
        });
      },
      css: function() {
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
      },
      js: function() {
        console.log('conf: ' + 'js');
        if (window.sn.theme.js != null) {
          return $.each(window.sn.theme.js, function(i) {
            return $.getScript(this);
          });
        }
      },
      settings: function() {
        var sn;
        sn = $(this).data('sn');
        console.log('conf: ' + 'settings.json');
        return $.ajax({
          url: 'conf/settings.json',
          async: false,
          dataType: 'json',
          success: function(s) {
            if (s != null) {
              $.extend(sn.settings, s);
              sn.settings.enable = true;
              sn.conf.settings = true;
            }
            return $(this).data('sn', sn);
          }
        });
      },
      wiki: function() {
        var sn;
        sn = $(this).data('sn');
        return window.sn.wiki = {
          images: {
            url: sn.settings.paths.images.url + sn.region.name + '/'
          },
          files: {
            url: sn.settings.paths.files.url + sn.region.name + '/'
          },
          gismeteo: {
            url: sn.settings.paths.widgets.gismeteo.url + sn.region.name + '/'
          }
        };
      }
    };
    return $.fn.snConf = function(sn) {
      if (sn == null) {
        sn = {};
      }
      if ($this[sn]) {
        return $this[sn].apply(this, Array.prototype.slice.call(arguments, 1));
      } else {
        return $this.init.apply(this, arguments);
      }
    };
  });

}).call(this);

/*
Дизайн
------
*/


(function() {
  $(function() {
    var $this;
    $this = {
      init: function(options) {
        if (options == null) {
          options = {};
        }
        return conlole.log('design');
      }
    };
    return $.fn.snDesign = function(sn) {
      if (sn == null) {
        sn = {};
      }
      if ($this[sn]) {
        return $this[sn].apply(this, Array.prototype.slice.call(arguments, 1));
      } else {
        return $this.init.apply(this, arguments);
      }
    };
  });

}).call(this);

/*
Роутинг приложения
*/


(function() {
  $(function() {
    var $this;
    $this = {
      init: function(options) {
        var def, href, levels;
        if (options == null) {
          options = {};
        }
        def = {
          href: '#autoload'
        };
        if (typeof options !== 'object') {
          href = options;
        } else {
          $.extend(true, def, options);
          href = def.href;
        }
        if (href !== '#' && href.match(/#([a-zA-Z0-9\_\-]+)/)) {
          levels = {
            one: href.match(/#([a-zA-Z0-9\_\-]+)/, '$2'),
            two: href.match(/#[a-zA-Z0-9\_\-]+\/([a-zA-Z0-9\_\-]+)/, '$3'),
            three: href.match(/#[a-zA-Z0-9\_\-]+\/[a-zA-Z0-9\_\-]+\/([a-zA-Z0-9\_\-]+)/, '$4'),
            anchor: href.match(/\:([a-zA-Z0-9\_\-]+)/)
          };
          console.info('url: ' + href);
          console.info('levels: ', levels);
          if ((levels.one != null) && levels.one[1] !== 'spoiler') {
            switch (levels.one[1]) {
              case 'autoload':
                $(this).snModels('#primary', {
                  file: 'main.html'
                });
                $(this).snModels('#side', {
                  file: 'side_main.html'
                });
                $(this).snTriggers('switch', 'side', 'main');
                $(this).snTriggers('links', 'bar');
                $(this).snTriggers('links', 'side');
                $(this).snTriggers('links', 'primary');
                $(this).snTriggers('hover', 'bar');
                $(this).snTriggers('hover', 'side');
                $(this).snTriggers('plugins', '#primary');
                $(this).snTriggers('plugins', '#side');
                window.sn.part = 'main';
                break;
              default:
                if ((levels.two != null) && (levels.three != null)) {
                  $.cookie('last_href', href, {
                    expires: 7
                  });
                  $('html,body').animate({
                    scrollTop: 0
                  }, 0);
                  if (levels.two[1] === 'text' && levels.one[1] !== window.sn.part) {
                    $(this).snModels('#side', {
                      file: 'side_' + levels.one[1] + '.html'
                    });
                    $(this).snModels('#primary', {
                      file: levels.three[1] + '.html'
                    });
                    $(this).snTriggers('links', 'side');
                    $(this).snTriggers('links', 'primary');
                    $(this).snTriggers('switch', 'bar', levels.one[1]);
                    $(this).snTriggers('switch', 'side', levels.three[1]);
                    $(this).snTriggers('hover', 'side');
                    $(this).snTriggers('plugins', '#primary');
                    $(this).snTriggers('plugins', '#side');
                  } else {
                    $(this).snModels('#primary', {
                      file: levels.three[1] + '.html'
                    });
                    $(this).snTriggers('links', 'primary');
                    $(this).snTriggers('switch', 'side', levels.three[1]);
                    $(this).snTriggers('plugins', '#primary');
                  }
                  window.sn.part = levels.one[1];
                }
            }
            $(this).snEvents('anchor', levels);
            return $(this).click(levels);
          }
        }
      },
      anchor: function(levels) {
        var e, height;
        if (levels.anchor != null) {
          try {
            if ($('#anchor-' + levels.anchor[1]).length) {
              height = $('#anchor-' + levels.anchor[1]).offset().top - 50;
              if (height) {
                if ($('#side-' + levels.anchor[1]).length) {
                  $(this).snTriggers('switchSide', {
                    'link': levels.anchor[1]
                  });
                }
                return $('html,body').animate({
                  scrollTop: height
                }, 'slow');
              }
            }
          } catch (_error) {
            e = _error;
            return console.error('anchor', e);
          }
        }
      }
    };
    return $.fn.snEvents = function(sn) {
      if (sn == null) {
        sn = {};
      }
      if ($this[sn]) {
        return $this[sn].apply(this, Array.prototype.slice.call(arguments, 1));
      } else {
        return $this.init.apply(this, arguments);
      }
    };
  });

}).call(this);

/*
Шаблон
------
*/


(function() {
  $(function() {
    var $this;
    $this = {
      init: function(options) {
        if (options == null) {
          options = {};
        }
        $(this).snModels('#bar', {
          layout: 'bar.html',
          wiki: false
        });
        return $(this).snModels('#main', {
          layout: 'main.html',
          wiki: false
        });
      }
    };
    return $.fn.snLayout = function(sn) {
      if (sn == null) {
        sn = {};
      }
      if ($this[sn]) {
        return $this[sn].apply(this, Array.prototype.slice.call(arguments, 1));
      } else {
        return $this.init.apply(this, arguments);
      }
    };
  });

}).call(this);

/*
Загрузка моделей
----------------
*/


(function() {
  $(function() {
    var $this;
    $this = {
      init: function(elem, options) {
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
        return $(this).snModels('append', def);
      },
      append: function(def) {
        var _this;
        if (def == null) {
          def = {};
        }
        _this = this;
        if (def.file != null) {
          return $(this).snModels('load', def.file, function(s) {
            def.text = s;
            return $(_this).snModels('inner', def);
          });
        } else {
          if (def.text != null) {
            return $(_this).snModels('inner', def);
          } else {
            if (def.view != null) {
              if (window.EJS != null) {
                def.text = new EJS({
                  url: 'view/' + def.view,
                  ext: '.html'
                }).render(window.sn);
                return $(_this).snModels('inner', def);
              }
            } else {
              if (def.layout != null) {
                if (window.EJS != null) {
                  def.text = new EJS({
                    url: 'layout/' + window.sn.region.name + '/' + def.layout,
                    ext: '.html'
                  }).render(window.sn);
                  return $(_this).snModels('inner', def);
                }
              }
            }
          }
        }
      },
      inner: function(options) {
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
          if (def.wiki === true && (window.sn.wiki != null)) {
            def.text = $(this).snWiki(def.text);
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
      },
      load: function(file, callback) {
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
      }
    };
    return $.fn.snModels = function(sn) {
      if (sn == null) {
        sn = {};
      }
      if ($this[sn]) {
        return $this[sn].apply(this, Array.prototype.slice.call(arguments, 1));
      } else {
        return $this.init.apply(this, arguments);
      }
    };
  });

}).call(this);

(function() {
  $(function() {
    var $this;
    $this = {
      init: function(options) {
        if (options == null) {
          options = {};
        }
      },
      "switch": function(type, link) {
        if (type == null) {
          type = '';
        }
        if (link == null) {
          link = '';
        }
        switch (type) {
          case 'side':
            return $(this).snTriggers('switchSide', link);
          case 'bar':
            return $(this).snTriggers('switchBar', link);
        }
      },
      plugins: function(elem) {
        if (elem == null) {
          elem = '#main';
        }
        return setTimeout(function() {
          if ($(elem + ' .tooltip-toggle').length) {
            $(elem + ' .tooltip-toggle').tooltip();
          }
          if ($.isFunction($.bootstrapIE6)) {
            $.bootstrapIE6(elem);
          }
          if ($(elem + ' .spoiler').length) {
            return $(elem).snTriggers('spoiler');
          }
        }, 1);
      },
      hover: function(type) {
        if (type == null) {
          type = '';
        }
        switch (type) {
          case 'side':
            return $(this).snTriggers('switcherSide');
          case 'bar':
            return $(this).snTriggers('switcherBar');
        }
      },
      links: function(type) {
        if (type == null) {
          type = '';
        }
        switch (type) {
          case 'side':
            return $(this).snTriggers('linksSide');
          case 'primary':
            return $(this).snTriggers('linksPrimary');
          case 'bar':
            return $(this).snTriggers('linksBar');
        }
      },
      linksSide: function() {
        var _this;
        console.log('trigger: ' + 'linksSide');
        _this = this;
        if ($('#primary a').length) {
          return $('#side a').on('click', function(e) {
            if ($(this).attr('href') !== '#' && !$(this).data('noevent')) {
              $('#side li').removeClass('active');
              $(this).parent('li').addClass('active');
              return $(_this).snEvents($(this).attr('href'));
            } else {
              return e.preventDefault();
            }
          });
        }
      },
      linksPrimary: function() {
        var _this;
        console.log('trigger: ' + 'linksPrimary');
        _this = this;
        if ($('#primary a').length) {
          return $('#primary a').on('click', function(e) {
            if ($(this).attr('href') !== '#' && !$(this).data('noevent')) {
              return $(_this).snEvents($(this).attr('href'));
            } else {
              return e.preventDefault();
            }
          });
        }
      },
      linksBar: function() {
        var _this;
        _this = this;
        console.log('trigger: ' + 'linksBar');
        if ($('#bar a').length && $('#bar li').length) {
          return $('#bar a').on('click', function(e) {
            if ($(this).attr('href') !== '#' && $(this).data('toggle') !== 'dropdown' && !$(this).data('noevent')) {
              $('#bar li').removeClass('active');
              $(this).parent('li').addClass('active');
              return $(_this).snEvents($(this).attr('href'));
            } else {
              return e.preventDefault();
            }
          });
        }
      },
      switchBar: function(link) {
        if (link == null) {
          return link = 'main';
        }
        /*
        			console.log 'trigger: ' + 'switchBar'
        
        			$('.bar-button')
        				.removeClass('bar-button-active')
        				.removeClass('bar-button-hover')
        				.addClass('bar-button-normal')
        
        			$('#bar-' + link)
        				.removeClass('bar-button-normal')
        				.removeClass('bar-button-hover')
        				.addClass('bar-button-active')
        				.blur()
        */

      },
      switchSide: function(link) {
        if (link == null) {
          return link = 'above';
        }
        /*
        			console.log 'trigger: ' + 'switchSide'
        
        			$('.side-box-link')
        				.removeClass('side-box-link-active')
        				.removeClass('side-box-link-hover')
        				.addClass('side-box-link-normal')
        
        			$('#side-' + link)
        				.removeClass('side-box-link-normal')
        				.removeClass('side-box-link-hover')
        				.addClass('side-box-link-active')
        				.blur()
        */

      },
      switcherBar: function() {
        console.log('trigger: ' + 'switcherBar');
        $('.bar-link').on('mouseover', function() {
          if (!$(this).parent('li').hasClass('active')) {
            return $(this).parent('li').removeClass('normal').addClass('hover');
          }
        });
        return $('.bar-link').on('mouseleave', function() {
          if (!$(this).parent('li').hasClass('active')) {
            return $(this).parent('li').removeClass('hover').addClass('normal');
          }
        });
      },
      switcherSide: function() {
        console.log('trigger: ' + 'switcherSide');
        $('.side-link').on('mouseover', function() {
          if (!$(this).parent('li').hasClass('active')) {
            return $(this).parent('li').removeClass('normal').addClass('hover');
          }
        });
        return $('.side-link').on('mouseleave', function() {
          if (!$(this).parent('li').hasClass('active')) {
            return $(this).parent('li').removeClass('hover').addClass('normal');
          }
        });
      },
      spoiler: function() {
        console.log('trigger: ' + 'spoiler');
        return $(this).find('.spoiler-caption').on('click', function(e) {
          e.preventDefault();
          if ($(this).hasClass('spoiler-open')) {
            $(this).removeClass('spoiler-open').addClass('spoiler-close');
          } else {
            $(this).removeClass('spoiler-close').addClass('spoiler-open');
          }
          return $(this).parent('.spoiler').children('.spoiler-body').each(function() {
            if ($(this).hasClass('spoiler-open')) {
              return $(this).removeClass('spoiler-open').addClass('spoiler-close').hide();
            } else {
              return $(this).removeClass('spoiler-close').addClass('spoiler-open').show();
            }
          });
        });
      }
    };
    return $.fn.snTriggers = function(sn) {
      if (sn == null) {
        sn = {};
      }
      if ($this[sn]) {
        return $this[sn].apply(this, Array.prototype.slice.call(arguments, 1));
      } else {
        return $this.init.apply(this, arguments);
      }
    };
  });

}).call(this);

(function() {
  $(function() {
    var $this;
    $this = {
      init: function(text, def) {
        var _base;
        if (text == null) {
          text = '';
        }
        if (def == null) {
          def = {};
        }
        if (window.sn == null) {
          window.sn = {};
        }
        if ((_base = window.sn).wiki == null) {
          _base.wiki = {
            images: {
              url: ''
            },
            files: {
              url: ''
            },
            gismeteo: {
              url: ''
            }
          };
        }
        console.log('wiki');
        text = $this.before(text);
        text = $this.formating(text);
        text = $this.headings(text);
        text = $this.icons(text);
        text = $this.externalLinks(text);
        text = $this.fileLinks(text);
        text = $this.internalLinks(text);
        text = $this.mailTo(text);
        text = $this.image(text);
        text = $this.fonts(text);
        text = $this.anchor(text);
        text = $this.ind(text);
        text = $this.gismeteo(text);
        text = $this.spoiler(text);
        text = $this.header(text);
        text = $this.spaces(text);
        text = $this.noevent(text);
        return text;
      },
      before: function(text) {
        return text.replace(/\|\n/g, '').replace(/\]\n\n/g, ']<br><br>').replace(/\]\n/g, ']<br>').replace(/>\n\n/g, '>\n');
      },
      formating: function(text) {
        return text.replace(/'''''(.*?)'''''/g, "<i><b>$1</b></i>").replace(/'''(.*?)'''/g, "<b>$1</b>").replace(/''(.*?)''/g, "<i>$1</i>");
      },
      headings: function(text) {
        text = text.replace(/======(.*?)======\n?/g, "<h6>$1</h6>");
        text = text.replace(/=====(.*?)=====\n?/g, "<h5>$1</h5>");
        text = text.replace(/====(.*?)====\n?/g, "<h4>$1</h4>");
        text = text.replace(/===(.*?)===\n?/g, "<h3>$1</h3>");
        return text = text.replace(/==(.*?)==\n?/g, "<h2>$1</h2>");
      },
      icons: function(text) {
        return text.replace(/\[(i|ico|icon|icons):icon-([a-zA-Z0-9\_\-]+)[\s]+(inverse|white)\]/g, '<i class="icon-$2 icon-white"></i> ').replace(/\[(i|ico|icon|icons):([a-zA-Z0-9\_\-]+)[\s]+(inverse|white)\]/g, '<i class="icon-$2 icon-white"></i> ').replace(/\[(i|ico|icon|icons):icon-([a-zA-Z0-9\_\-]+)\]/g, '<i class="icon-$2"></i> ').replace(/\[(i|ico|icon|icons):([a-zA-Z0-9\_\-]+)\]/g, '<i class="icon-$2"></i> ').replace(/([\s]+)(i|ico|icon|icons):icon-([a-zA-Z0-9\_\-]+)[\s]+(inverse|white)([\s]+)/g, '$1<i class="icon-$3 icon-white"></i>$4').replace(/([\s]+)(i|ico|icon|icons):([a-zA-Z0-9\_\-]+)[\s]+(inverse|white)([\s]+)/g, '$1<i class="icon-$3 icon-white"></i>$4').replace(/([\s]+)(i|ico|icon|icons):icon-([a-zA-Z0-9\_\-]+)([\s]+)/g, '$1<i class="icon-$3"></i>$4').replace(/([\s]+)(i|ico|icon|icons):([a-zA-Z0-9\_\-]+)([\s]+)/g, '$1<i class="icon-$3"></i>$4');
      },
      internalLinks: function(text) {
        return text.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="#$3" class="btn btn-$2 tooltip-toggle" data-placement="$6" rel="tooltip" title="$5">$4</a>').replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="#$3" class="btn btn-$2 tooltip-toggle" rel="tooltip" title="$5">$4</a>').replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="#$3" class="btn btn-$2 tooltip-toggle" data-placement="$5" rel="tooltip" title="$4">$3</a>').replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="#$3" class="btn btn-$2 tooltip-toggle" rel="tooltip" title="$4">$3</a>').replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a class="btn btn-$2" href="#$3">$4</a>').replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)\]/g, '<a class="btn btn-$2" href="#$1">$1</a>').replace(/\[b(tn|utton)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="#$2" class="btn tooltip-toggle" data-placement="$5" rel="tooltip" title="$4">$3</a>').replace(/\[b(tn|utton)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="#$2" class="btn tooltip-toggle" rel="tooltip" title="$4">$3</a>').replace(/\[b(tn|utton)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="#$2" class="btn tooltip-toggle" data-placement="$4" rel="tooltip" title="$3">$2</a>').replace(/\[b(tn|utton)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="#$2" class="btn tooltip-toggle" rel="tooltip" title="$3">$2</a>').replace(/\[b(tn|utton)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a class="btn" href="#$2">$3</a>').replace(/\[b(tn|utton)[\s]+#([a-zA-Z0-9\-\.\/\?%\#_\:]+)\]/g, '<a href="#$1">$1</a>').replace(/\[#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="#$1" class="tooltip-toggle" data-placement="$4" rel="tooltip" title="$3">$2</a>').replace(/\[#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="#$1" class="tooltip-toggle" rel="tooltip" title="$3">$2</a>').replace(/\[#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="#$1" class="tooltip-toggle" data-placement="$3" rel="tooltip" title="$2">$1</a>').replace(/\[#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="#$1" class="tooltip-toggle" rel="tooltip" title="$2">$1</a>').replace(/\[#([a-zA-Z0-9\-\.\/\?%\#_\:]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="#$1">$2</a>').replace(/\[#([a-zA-Z0-9\-\.\/\?%\#_\:]+)\]/g, '<a href="#$1">$1</a>').replace(/([\s+])#([a-zA-Z0-9\-\.\/\?%\#_\:]+)([\s]+)/g, '$1<a href="#$2">$2</a>$3');
      },
      externalLinks: function(text) {
        return text.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+) (left|top|right|bottom)\]/g, '<a href="http://$3" class="btn btn-$2 tooltip-toggle" data-placement="$6" rel="tooltip" title="$5" target="_blank">$4</a>').replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="http://$3" class="btn btn-$2 tooltip-toggle" rel="tooltip" title="$5" target="_blank">$4</a>').replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="http://$3" class="btn btn-$2 tooltip-toggle" data-placement="$5" rel="tooltip" title="$4" target="_blank">$3</a>').replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="http://$3" class="btn btn-$2 tooltip-toggle" rel="tooltip" title="$4" target="_blank">$3</a>').replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="http://$3" class="btn btn-$2" target="_blank">$4</a>').replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)\]/g, '<a class="btn btn-$2" href="http://$2" target="_blank">$2</a>').replace(/\[b(tn|utton)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+) (left|top|right|bottom)\]/g, '<a href="http://$2" class="btn tooltip-toggle" data-placement="$5" rel="tooltip" title="$4" target="_blank">$3</a>').replace(/\[b(tn|utton)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="http://$2" class="btn tooltip-toggle" rel="tooltip" title="$4" target="_blank">$3</a>').replace(/\[b(tn|utton)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="http://$2" class="btn tooltip-toggle" data-placement="$4" rel="tooltip" title="$3" target="_blank">$2</a>').replace(/\[b(tn|utton)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="http://$2" class="tooltip-toggle" rel="tooltip" title="$3" target="_blank">$2</a>').replace(/\[b(tn|utton)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a class="btn" href="http://$2" target="_blank">$3</a>').replace(/\[b(tn|utton)[\s]+https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)\]/g, '<a class="btn" href="http://$2" target="_blank">$2</a>').replace(/\[https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="http://$1" class="tooltip-toggle" data-placement="$4" rel="tooltip" title="$3" target="_blank">$2</a>').replace(/\[https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="http://$1" class="tooltip-toggle" rel="tooltip" title="$3" target="_blank">$2</a>').replace(/\[https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="http://$1" class="tooltip-toggle" data-placement="$3" rel="tooltip" title="$2" target="_blank">$1</a>').replace(/\[https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="http://$1" class="tooltip-toggle" rel="tooltip" title="$2" target="_blank">$1</a>').replace(/\[https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="http://$1" target="_blank">$2</a>').replace(/\[https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)\]/g, '<a href="http://$1" target="_blank">$1</a>').replace(/([\s]+)https?:\/\/([a-zA-Z0-9\-\.\/\?\%\#\_]+)([\s]+)/g, '$1<a href="http://$2" target="_blank">$2</a>$3');
      },
      fileLinks: function(text) {
        return text.replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="' + window.sn.wiki.files.url + '$3" class="btn btn-$2 tooltip-toggle" rel="tooltip" data-placement="$6" title="$5" target="_blank">$4</a>').replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="' + window.sn.wiki.files.url + '$3" class="btn btn-$2 tooltip-toggle" rel="tooltip" title="$5" target="_blank">$4</a>').replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="' + window.sn.wiki.files.url + '$3" class="btn btn-$2 tooltip-toggle" rel="tooltip" data-placement="$5" title="$4" target="_blank">$3</a>').replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="' + window.sn.wiki.files.url + '$3" class="btn btn-$2 tooltip-toggle" rel="tooltip" title="$4" target="_blank">$3</a>').replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a class="btn btn-$2" href="' + window.sn.wiki.files.url + '$3" target="_blank">$4</a>').replace(/\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)\]/g, '<a class="btn btn-$2" href="' + window.sn.wiki.files.url + '$3" target="_blank">$3</a>').replace(/\[b(tn|utton)[\s]+files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="' + window.sn.wiki.files.url + '$2" class="btn tooltip-toggle" rel="tooltip" data-placement="$5" title="$4" target="_blank">$3</a>').replace(/\[b(tn|utton)[\s]+files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="' + window.sn.wiki.files.url + '$2" class="btn tooltip-toggle" rel="tooltip" title="$4" target="_blank">$3</a>').replace(/\[b(tn|utton)[\s]+files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="' + window.sn.wiki.files.url + '$2" class="btn tooltip-toggle" rel="tooltip" data-placement="$4" title="$3" target="_blank">$2</a>').replace(/\[b(tn|utton)[\s]+files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="' + window.sn.wiki.files.url + '$2" class="btn tooltip-toggle" rel="tooltip" title="$3" target="_blank">$2</a>').replace(/\[b(tn|utton)[\s]+files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a class="btn" href="' + window.sn.wiki.files.url + '$2" target="_blank">$3</a>').replace(/\[b(tn|utton)[\s]+files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)\]/g, '<a class="btn" href="' + window.sn.wiki.files.url + '$2" target="_blank">$2</a>').replace(/\[files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="' + window.sn.wiki.files.url + '$1" class="tooltip-toggle" rel="tooltip" data-placement="$4" title="$3" target="_blank">$2</a>').replace(/\[files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="' + window.sn.wiki.files.url + '$1" class="tooltip-toggle" rel="tooltip" title="$3" target="_blank">$2</a>').replace(/\[files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(left|top|right|bottom)\]/g, '<a href="' + window.sn.wiki.files.url + '$1" class="tooltip-toggle" rel="tooltip" data-placement="$3" title="$2" target="_blank">$1</a>').replace(/\[files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+\|[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="' + window.sn.wiki.files.url + '$1" class="tooltip-toggle" rel="tooltip" title="$2" target="_blank">$1</a>').replace(/\[files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<a href="' + window.sn.wiki.files.url + '$1" target="_blank">$2</a>').replace(/\[files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)\]/g, '<a href="' + window.sn.wiki.files.url + '$1" target="_blank">$1</a>').replace(/([\s]+)files?:([a-zA-Z0-9\-\.\/\?\%\#\_]+)([\s]+)/g, '$1<a href="' + window.sn.wiki.files.url + '$2" target="_blank">$2</a>$3');
      },
      mailTo: function(text) {
        return text.replace(/\[e\-?mail:([a-zA-Z0-9@\-\.\/\?%\#_]+)[\s]+(.*?)\]/g, '<a href="mailto:$1">$2</a>').replace(/\[e\-?mail:([a-zA-Z0-9@\-\.\/\?%\#_]+)\]/g, '<a href="mailto:$1">$1</a>');
      },
      image: function(text, options) {
        return text.replace(/\[(img|image|picture|photo):([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+(right|left)\]/g, '<img class="pull-$3" src="' + window.sn.wiki.images.url + '$2">').replace(/\[(img|image|picture|photo):([a-zA-Z0-9\-\.\/\?\%\#\_]+)\]/g, '<img src="' + window.sn.wiki.images.url + '$2">').replace(/([\s]+)(img|image|picture|photo):([a-zA-Z0-9\-\.\/\?\%\#\_]+)[\s]+(right|left)([\s]+)/g, '$1<img class="pull-$4" src="' + window.sn.wiki.images.url + '$3">$5').replace(/([\s]+)(img|image|picture|photo):([a-zA-Z0-9\-\.\/\?\%\#\_]+)([\s]+)/g, '$1<img src="' + window.sn.wiki.images.url + '$3">$4');
      },
      fonts: function(text) {
        return text.replace(/\[badge[\s]+(success|warning|important|info|inverse)\][\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)/g, '<span class="badge badge-$1">$2</span>').replace(/\[badge[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(success|warning|important|info|inverse)\]/g, '<span class="badge badge-$2">$1</span>').replace(/\[badge[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<span class="badge">$1</span>').replace(/\[label[\s]+(success|warning|important|info|inverse)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<span class="label label-$1">$2</span>').replace(/\[label[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)[\s]+(success|warning|important|info|inverse)\]/g, '<span class="label label-$2">$1</span>').replace(/\[label[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<span class="label">$1</span>').replace(/\[color:\#([a-zA-Z0-9]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<font style="color:#$1">$2</font>').replace(/\[color:([a-zA-Z0-9]+)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]/g, '<span class="$1">$2</span>').replace(/\[\[color:\#([a-zA-Z0-9]+)\](.*?)\]/g, '<font style="color:#$1">$2</font>').replace(/\[\[color:([a-zA-Z0-9]+)\](.*?)\]/g, '<span class="$1">$2</span>');
      },
      ind: function(text) {
        return text.replace(/<<<\#?\:?([a-zA-Z0-9\-\.\/\?\_]+)\n?/g, '<div class="well well-small"><a id="anchor-$1"></a>').replace(/<<<\n?/g, '<div class="well well-small">').replace(/>>>\n?/g, '</div>');
      },
      anchor: function(text) {
        return text.replace(/\[anchor:([a-zA-Z0-9\-\.\/\?\%\#\_]+)\]\n?/g, '<a id="anchor-$1"></a>');
      },
      gismeteo: function(text) {
        return text.replace(/\[gismeteo\]\n?/g, '<iframe src="' + window.sn.wiki.gismeteo.url + '" width="96%" height="160" scrolling="no" marginheight="0" marginwidth="0" frameborder="0"></iframe>&nbsp;');
      },
      spoiler: function(text) {
        return text.replace(/<<\[b(tn|utton)[\s]+(primary|info|success|warning|danger|inverse|link)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]\n?/g, '<div class="spoiler">' + '<a href="#spoiler" class="btn btn-$2 spoiler-caption spoiler-close">' + '<span class="caret"></span>&nbsp;$3</a><p>' + '<div class="hide spoiler-body spoiler-close"><pre>').replace(/<<\[b(tn|utton)[\s]+([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]\n?/g, '<div class="spoiler">' + '<a href="#spoiler" class="btn spoiler-caption spoiler-close">' + '<span class="caret"></span>&nbsp;$2</a><p>' + '<div class="hide spoiler-body spoiler-close"><pre>').replace(/<<\[([\s0-9a-zA-Zа-яА-Я\_\.\/\-\?\!\*\#\'\"\<\>\=\,\;\:\(\)\№\«\»]+)\]\n?/g, '<div class="spoiler">' + '<a href="#spoiler" class="spoiler-caption spoiler-close">' + '$1</a><p>' + '<div class="hide spoiler-body spoiler-close"><pre>').replace(/>>\n?/g, '</pre></div></p></div>');
      },
      header: function(text) {
        return text.replace(/<\[\n?/g, '<div class="page-header">').replace(/\]>\n?/g, '</div>');
      },
      spaces: function(text) {
        return text.replace(/^\n/, "").replace(/\n\n/g, "<br><br>").replace(/>\n?/g, '>').replace(/<pre><br>/g, '<pre>').replace(/\n/g, "<br>");
      },
      noevent: function(text) {
        return text.replace(/(href="#")/g, '$1 data-noevent="true"');
      }
    };
    return $.fn.snWiki = function(sn) {
      if (sn == null) {
        sn = {};
      }
      if ($this[sn]) {
        return $this[sn].apply(this, Array.prototype.slice.call(arguments, 1));
      } else {
        return $this.init.apply(this, arguments);
      }
    };
  });

}).call(this);

(function() {
  $(function() {
    var $this;
    $this = {
      init: function(options) {
        if (options == null) {
          options = {};
        }
      },
      checkEnterForm: function(options) {
        var sn;
        if (options == null) {
          options = {};
        }
        sn = $(this).data('sn');
        console.log('enter: ' + 'checkEnterForm');
        alert('enter');
        console.info('sn', sn);
        return false;
      }
    };
    return $.fn.snEnter = function(sn) {
      if (sn == null) {
        sn = {};
      }
      if ($this[sn]) {
        return $this[sn].apply(this, Array.prototype.slice.call(arguments, 1));
      } else {
        return $this.init.apply(this, arguments);
      }
    };
  });

}).call(this);

(function() {
  $(function() {
    var $this;
    $this = {
      init: function(options) {
        if (options == null) {
          options = {};
        }
      },
      checkRegForm: function(options) {
        var def, _this;
        if (options == null) {
          options = {};
        }
        _this = this;
        console.log('registration: ' + 'checkRegForm');
        def = {
          error: false
        };
        $.extend(true, def, options);
        $('.signin-warning').hide();
        $('.signin-form-warning').hide();
        $('.signin-type-reg').each(function() {
          var check, __this;
          __this = this;
          check = $(_this).snValidation('checkField', {
            type: $(this).data('check-type'),
            value: $(this).val(),
            caption: $(this).data('def-value')
          });
          if (check.error !== void 0) {
            if (check.error) {
              def.error = true;
            }
          }
          $('.signin-warning').each(function() {
            if ($(this).data('check-type') === $(__this).data('check-type')) {
              if (check.error !== void 0) {
                if (check.error) {
                  return $(this).html(check.start + ' ' + check.caption + ' ' + check.exp).show();
                }
              }
            }
          });
          $('.signin-form-warning').each(function() {
            if ($(this).data('check-type') === $(__this).data('check-type')) {
              if (check.error !== void 0) {
                if (check.error) {
                  return $(this).show();
                }
              }
            }
          });
          return $('.signin-form-check').each(function() {
            if ($(this).data('check-type') === $(__this).data('check-type')) {
              if (check.error !== void 0) {
                if ($(this).hasClass('signin-form-check-clear')) {
                  $(this).removeClass('signin-form-check-clear');
                }
                if (check.error) {
                  $(this).removeClass('signin-form-check-true');
                  return $(this).addClass('signin-form-check-false');
                } else {
                  $(this).removeClass('signin-form-check-false');
                  return $(this).addClass('signin-form-check-true');
                }
              }
            }
          });
        });
        console.info('afterCheckRegForm', def);
        $(this).snRegistration('afterCheckRegForm', def);
        return false;
      },
      afterCheckRegForm: function(options) {
        var def;
        if (options == null) {
          options = {};
        }
        console.log('registration: ' + 'afterCheckRegForm');
        def = {
          error: false
        };
        $.extend(true, def, options);
        if (def.error) {
          return console.warn('ошибки при проверке формы регистрации');
        } else {
          alert('bez oshibok');
          console.info('regOnServer');
          return $(this).snRegistration('regOnServer');
        }
      },
      regOnServer: function(options) {
        var def, sn, _this;
        if (options == null) {
          options = {};
        }
        console.log('registration: ' + 'regOnServer');
        def = {
          debug: false,
          type: 'jsonp',
          firstname: $('#signin-input-firstname').val(),
          lastname: $('#signin-input-lastname').val(),
          patronymic: $('#signin-input-patronymic').val(),
          email: $('#signin-input-email').val(),
          phone: $('#signin-input-phone').val(),
          company: $('#signin-input-company').val(),
          post: $('#signin-input-post').val(),
          error: false
        };
        _this = this;
        $.extend(true, def, options);
        if (def.debug) {
          def.type = 'text';
        }
        sn = $(this).data('sn');
        return $.ajax({
          url: 'http://oz.st-n.ru/server-dev/?callback=?',
          async: false,
          type: 'POST',
          data: {
            action: 'registration',
            region: sn.region.name,
            theme: sn.theme.name,
            firstname: def.firstname,
            lastname: def.lastname,
            patronymic: def.patronymic,
            email: def.email,
            phone: def.phone,
            company: def.company,
            post: def.post
          },
          dataType: def.type,
          timeout: 10000,
          success: function(s) {
            $.extend(true, sn.result, s.registration);
            if (def.debug) {
              alert(s);
            }
            $(_this).data('sn', sn);
            if (sn.result.alert) {
              alert(sn.result.alert);
            }
            console.log('afterCheckRegFormOnServer', s);
            return $(_this).snRegistration('afterCheckRegFormOnServer', s);
          },
          error: function(XMLHttpRequest, textStatus, error) {
            return console.error('ajax:', textStatus, error);
          }
        });
      },
      afterSuccessReg: function(options) {
        var sn;
        if (options == null) {
          options = {};
        }
        sn = $(this).data('sn');
        console.log('registration: ' + 'afterSuccessReg');
        return alert('afterSuccessReg');
      },
      afterCheckRegFormOnServer: function(options) {
        var def, sn;
        if (options == null) {
          options = {};
        }
        console.log('registration: ' + 'afterCheckRegFormOnServer');
        def = {
          'error': false,
          'start': 'В поле'
        };
        $.extend(true, def, options);
        sn = $(this).data('sn');
        if (sn.result.reg) {
          $(this).snRegistration('afterSuccessReg', def);
        }
        if (!sn.result.reg) {
          def.error = true;
          if (sn.result.valid) {
            return $.each(sn.result.valid, function(field, check) {
              $('.signin-warning').each(function() {
                if ($(this).data('check-type') === field) {
                  if (check.error !== void 0) {
                    if (check.error) {
                      return $(this).html(def.start + ' ' + check.def + ' ' + check.exp).show();
                    }
                  }
                }
              });
              $('.signin-form-warning').each(function() {
                if ($(this).data('check-type') === field) {
                  if (check.error !== void 0) {
                    if (check.error) {
                      return $(this).show();
                    }
                  }
                }
              });
              return $('.signin-form-check').each(function() {
                if ($(this).data('check-type') === field) {
                  if (check.error !== void 0) {
                    if ($(this).hasClass('signin-form-check-clear')) {
                      $(this).removeClass('signin-form-check-clear');
                    }
                    if (check.error) {
                      return $(this).removeClass('signin-form-check-true').addClass('signin-form-check-false');
                    } else {
                      return $(this).removeClass('signin-form-check-false').addClass('signin-form-check-true');
                    }
                  }
                }
              });
            });
          }
        }
      }
    };
    return $.fn.snRegistration = function(sn) {
      if (sn == null) {
        sn = {};
      }
      if ($this[sn]) {
        return $this[sn].apply(this, Array.prototype.slice.call(arguments, 1));
      } else {
        return $this.init.apply(this, arguments);
      }
    };
  });

}).call(this);

(function() {
  $(function() {
    var $this;
    $this = {
      init: function(options) {
        var def, sn;
        if (options == null) {
          options = {};
        }
        sn = $(this).data('sn');
        def = {};
        $.extend(true, def, options);
        console.log('signin: ' + 'init');
        console.log('render: ', def);
        $(this).snModels('primary', {
          view: 'signin.html'
        });
        $(this).snModels('side', {
          view: 'signinSide.html'
        });
        $(this).snTriggers('switch', 'side', sn.levels.two);
        $(this).snTriggers('switch', 'bar', sn.levels.one);
        $(this).snTriggers('links', 'side');
        $(this).snTriggers('hover', 'side');
        return $(this).snSignin('triggers', def);
      },
      help: function(options) {
        var def;
        if (options == null) {
          options = {};
        }
        console.log('signin: ' + 'help');
        def = {};
        $.extend(true, def, options);
        $(this).snModels('primary', {
          view: 'signinBlockHelp.html',
          position: 'before'
        });
        return $(this).snSignin('triggers');
      },
      triggers: function(options) {
        var _this;
        if (options == null) {
          options = {};
        }
        _this = this;
        console.log('signin: ' + 'triggers');
        $('.signin-input').on('focus', function() {
          if ($(this).val() === $(this).data('def-value') || $(this).val() === '') {
            $(this).removeClass('signin-input-blur');
            $(this).addClass('signin-input-focus');
            $(this).val('');
            return $(this).select();
          }
        });
        $('.signin-input').on('blur', function() {
          if ($(this).val() === $(this).data('def-value') || $(this).val() === '') {
            $(this).removeClass('signin-input-focus');
            $(this).addClass('signin-input-blur');
            return $(this).val($(this).data('def-value'));
          }
        });
        $('#signin-form-enter').on('submit', function(e) {
          e.preventDefault();
          return $(_this).snEnter('checkEnterForm');
        });
        $('#signin-button-enter').on('click', function(e) {
          e.preventDefault();
          return $(_this).snEnter('checkEnterForm');
        });
        $('#signin-form-reg').on('submit', function(e) {
          e.preventDefault();
          return $(_this).snRegistration('checkRegForm');
        });
        $('#signin-button-reg').on('click', function(e) {
          e.preventDefault();
          return $(_this).snRegistration('checkRegForm');
        });
        return $('.signin-type-reg').on('keyup', function() {
          var check, __this;
          __this = this;
          check = $(_this).snValidation('checkField', {
            type: $(this).data('check-type'),
            value: $(this).val(),
            caption: $(this).data('def-value')
          });
          return $('.signin-form-check').each(function() {
            if ($(this).data('check-type') === $(__this).data('check-type')) {
              if (check.error != null) {
                if ($(this).hasClass('signin-form-check-clear')) {
                  $(this).removeClass('signin-form-check-clear');
                }
                if (check.error) {
                  $(this).removeClass('signin-form-check-true');
                  return $(this).addClass('signin-form-check-false');
                } else {
                  $(this).removeClass('signin-form-check-false');
                  return $(this).addClass('signin-form-check-true');
                }
              }
            }
          });
        });
      }
    };
    return $.fn.snSignin = function(sn) {
      if (sn == null) {
        sn = {};
      }
      if ($this[sn]) {
        return $this[sn].apply(this, Array.prototype.slice.call(arguments, 1));
      } else {
        return $this.init.apply(this, arguments);
      }
    };
  });

}).call(this);

(function() {
  $(function() {
    var $this;
    $this = {
      init: function(options) {
        var _this;
        if (options == null) {
          options = {};
        }
        _this = this;
        return $(this).on('click', function() {
          var sn;
          sn = $(_this).data('sn');
          if (sn.levels.one === 'users') {
            switch (sn.levels.two) {
              case 'signin':
                return $(_this).snSignin();
              case 'help':
                return $(_this).snSignin('help');
            }
          }
        });
      }
    };
    $.fn.snUsers = function(sn) {
      if (sn == null) {
        sn = {};
      }
      if ($this[sn]) {
        return $this[sn].apply(this, Array.prototype.slice.call(arguments, 1));
      } else {
        return $this.init.apply(this, arguments);
      }
    };
    return $('#sn').snUsers();
  });

}).call(this);

(function() {
  $(function() {
    var $this;
    $this = {
      init: function(options) {
        if (options == null) {
          options = {};
        }
        return $(this).snValidation('checkField', options);
      },
      checkField: function(options) {
        var def, value;
        if (options == null) {
          options = {};
        }
        def = {
          type: 'post',
          value: '',
          caption: '',
          error: true,
          start: 'В поле',
          exp: ''
        };
        $.extend(true, def, options);
        value = def.value.toString();
        console.log('validation: ' + def.type + ' - ' + value);
        switch (def.type) {
          case 'firstname':
            if (value === '' || value === def.caption) {
              def.exp = 'ничего не указано!';
            } else {
              if (value.length < 3) {
                def.exp = 'слишком короткое значение!';
              } else {
                if (value.length > 28) {
                  def.exp = 'слишком длинное значение!';
                } else {
                  if (!value.match(/^([а-я\-\.]+)$/gi)) {
                    def.exp = 'некорректное значение!';
                  } else {
                    def.error = false;
                  }
                }
              }
            }
            break;
          case 'lastname':
            if (value === '' || value === def.caption) {
              def.exp = 'ничего не указано!';
            } else {
              if (value.length < 3) {
                def.exp = 'слишком короткое значение!';
              } else {
                if (value.length > 28) {
                  def.exp = 'слишком длинное значение!';
                } else {
                  if (!value.match(/^([а-я\-\.]+)$/gi)) {
                    def.exp = 'некорректное значение!';
                  } else {
                    def.error = false;
                  }
                }
              }
            }
            break;
          case 'patronymic':
            if (value === '' || value === def.caption) {
              def.exp = 'ничего не указано!';
            } else {
              if (value.length < 3) {
                def.exp = 'слишком короткое значение!';
              } else {
                if (value.length > 28) {
                  def.exp = 'слишком длинное значение!';
                } else {
                  if (!value.match(/^([а-я\-\.]+)$/gi)) {
                    def.exp = 'некорректное значение!';
                  } else {
                    def.error = false;
                  }
                }
              }
            }
            break;
          case 'email':
            if (value === '' || value === def.caption) {
              def.exp = 'ничего не указано!';
            } else {
              if (value.length < 3) {
                def.exp = 'слишком короткое значение!';
              } else {
                if (value.length > 28) {
                  def.exp = 'слишком длинное значение!';
                } else {
                  if (!value.match(/\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b/gi)) {
                    def.exp = 'некорректное значение!';
                  } else {
                    def.error = false;
                  }
                }
              }
            }
            break;
          case 'phone':
            if (value === '' || value === def.caption) {
              def.exp = 'ничего не указано!';
            } else {
              if (value.length < 3) {
                def.exp = 'слишком короткое значение!';
              } else {
                if (value.length > 28) {
                  def.exp = 'слишком длинное значение!';
                } else {
                  if (!value.match(/\+?\d{1,3}(?:\s*\(\d+\)\s*)?(?:(?:\-\d{1,3})+\d|[\d\-]{4,}|(?:\s\d{1,3})+\d)/gi)) {
                    def.exp = 'некорректное значение!';
                  } else {
                    def.error = false;
                  }
                }
              }
            }
            break;
          case 'company':
            if (value === '' || value === def.caption) {
              def.exp = 'ничего не указано!';
            } else {
              if (value.length < 3) {
                def.exp = 'слишком короткое значение!';
              } else {
                if (value.length > 28) {
                  def.exp = 'слишком длинное значение!';
                } else {
                  if (!value.match(/^([а-яa-z0-9\-\.\,\'\'\<\>\ ]+)$/gi)) {
                    def.exp = 'некорректное значение!';
                  } else {
                    def.error = false;
                  }
                }
              }
            }
            break;
          case 'post':
            if (value === '' || value === def.caption) {
              def.exp = 'ничего не указано!';
            } else {
              if (value.length < 3) {
                def.exp = 'слишком короткое значение!';
              } else {
                if (value.length > 28) {
                  def.exp = 'слишком длинное значение!';
                } else {
                  if (!value.match(/^([а-яa-z0-9\-\.\,\'\'\ ]+)$/gi)) {
                    def.exp = 'некорректное значение!';
                  } else {
                    def.error = false;
                  }
                }
              }
            }
        }
        if (!def.error) {
          console.warn(def.exp);
        }
        return def;
      }
    };
    return $.fn.snValidation = function(sn) {
      if (sn == null) {
        sn = {};
      }
      if ($this[sn]) {
        return $this[sn].apply(this, Array.prototype.slice.call(arguments, 1));
      } else {
        return $this.init.apply(this, arguments);
      }
    };
  });

}).call(this);
