var snEvents;

require('jquery');

require('cookie');

module.exports = snEvents = (function() {
  function snEvents() {}

  snEvents.prototype.get = function(options) {
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
    href = href.replace(/.*(?=#[^\s]+$)/, '');
    if (href !== '#' && href.match(/#[a-zA-Z0-9\_\-]+/)) {
      levels = href.match(/[a-zA-Z0-9\_\-]+/g);
      console.info('url: ' + href);
      console.info('levels: ', levels);
      if ((levels[0] != null) && levels[0] !== 'spoiler') {
        switch (levels[0]) {
          case 'autoload':
            window.models.get('#primary', {
              file: 'main.html'
            });
            window.models.get('#side', {
              file: 'side_main.html'
            });
            window.triggers["switch"]('side', 'main');
            window.triggers.links('bar');
            window.triggers.links('side');
            window.triggers.links('primary');
            window.triggers.hover('bar');
            window.triggers.hover('side');
            window.triggers.plugins('#primary');
            window.triggers.plugins('#side');
            return window.sn.part = 'main';
          default:
            if ((levels[1] != null) && (levels[2] != null)) {
              $.cookie('last_href', href, {
                expires: 7
              });
              $('html,body').animate({
                scrollTop: 0
              }, 0);
              if (levels[1] === 'text' && levels[0] !== window.sn.part) {
                window.models.get('#side', {
                  file: 'side_' + levels[0] + '.html'
                });
                window.models.get('#primary', {
                  file: levels[2] + '.html'
                });
                window.triggers.links('side');
                window.triggers.links('primary');
                window.triggers["switch"]('bar', levels[0]);
                window.triggers["switch"]('side', levels[2]);
                window.triggers.hover('side');
                window.triggers.plugins('#primary');
                window.triggers.plugins('#side');
              } else {
                window.models.get('#primary', {
                  file: levels[2] + '.html'
                });
                window.triggers.links('primary');
                window.triggers["switch"]('side', levels[2]);
                window.triggers.plugins('#primary');
              }
              return window.sn.part = levels[0];
            }
        }
      }
    }
  };

  return snEvents;

})();
