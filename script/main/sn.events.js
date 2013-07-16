require('jquery');

$(function() {
  return window.snEvents = (function() {
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
              if ((levels.two != null) && (levels.three != null)) {
                $.cookie('last_href', href, {
                  expires: 7
                });
                $('html,body').animate({
                  scrollTop: 0
                }, 0);
                if (levels.two[1] === 'text' && levels.one[1] !== window.sn.part) {
                  window.models.get('#side', {
                    file: 'side_' + levels.one[1] + '.html'
                  });
                  window.models.get('#primary', {
                    file: levels.three[1] + '.html'
                  });
                  window.triggers.links('side');
                  window.triggers.links('primary');
                  window.triggers["switch"]('bar', levels.one[1]);
                  window.triggers["switch"]('side', levels.three[1]);
                  window.triggers.hover('side');
                  window.triggers.plugins('#primary');
                  window.triggers.plugins('#side');
                } else {
                  window.models.get('#primary', {
                    file: levels.three[1] + '.html'
                  });
                  window.triggers.links('primary');
                  window.triggers["switch"]('side', levels.three[1]);
                  window.triggers.plugins('#primary');
                }
                return window.sn.part = levels.one[1];
              }
          }
        }
      }
    };

    return snEvents;

  })();
});
