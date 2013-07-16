require('jquery');

require('bootstrap');

$(function() {
  return window.snTriggers = (function() {
    function snTriggers(options) {
      this.options = options != null ? options : {};
    }

    snTriggers.prototype["switch"] = function(type, link) {
      if (type == null) {
        type = '';
      }
      if (link == null) {
        link = '';
      }
      switch (type) {
        case 'side':
          return this.switchSide(link);
        case 'bar':
          return this.switchBar(link);
      }
    };

    snTriggers.prototype.plugins = function(elem) {
      var _this;
      if (elem == null) {
        elem = '#main';
      }
      _this = this;
      return setTimeout(function() {
        if ($(elem + ' .tooltip-toggle').length) {
          $(elem + ' .tooltip-toggle').tooltip();
        }
        if ($.isFunction($.bootstrapIE6)) {
          $.bootstrapIE6(elem);
        }
        if ($(elem + ' .spoiler').length) {
          return _this.spoiler(elem);
        }
      }, 1);
    };

    snTriggers.prototype.hover = function(type) {
      if (type == null) {
        type = '';
      }
      switch (type) {
        case 'side':
          return this.switcherSide();
        case 'bar':
          return this.switcherBar();
      }
    };

    snTriggers.prototype.links = function(type) {
      if (type == null) {
        type = '';
      }
      switch (type) {
        case 'side':
          return this.linksSide();
        case 'primary':
          return this.linksPrimary();
        case 'bar':
          return this.linksBar();
      }
    };

    snTriggers.prototype.linksSide = function() {
      console.log('trigger: ' + 'linksSide');
      if ($('#primary a').length) {
        return $('#side a').on('click', function(e) {
          if ($(this).attr('href') !== '#' && !$(this).data('noevent')) {
            $('#side li').removeClass('active');
            $(this).parent('li').addClass('active');
            return window.events.get($(this).attr('href'));
          } else {
            return e.preventDefault();
          }
        });
      }
    };

    snTriggers.prototype.linksPrimary = function() {
      console.log('trigger: ' + 'linksPrimary');
      if ($('#primary a').length) {
        return $('#primary a').on('click', function(e) {
          if ($(this).attr('href') !== '#' && !$(this).data('noevent')) {
            return window.events.get($(this).attr('href'));
          } else {
            return e.preventDefault();
          }
        });
      }
    };

    snTriggers.prototype.linksBar = function() {
      console.log('trigger: ' + 'linksBar');
      if ($('#bar a').length && $('#bar li').length) {
        return $('#bar a').on('click', function(e) {
          if ($(this).attr('href') !== '#' && $(this).data('toggle') !== 'dropdown' && !$(this).data('noevent')) {
            $('#bar li').removeClass('active');
            $(this).parent('li').addClass('active');
            return window.events.get($(this).attr('href'));
          } else {
            return e.preventDefault();
          }
        });
      }
    };

    snTriggers.prototype.switchBar = function(link) {
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

    };

    snTriggers.prototype.switchSide = function(link) {
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

    };

    snTriggers.prototype.switcherBar = function() {
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
    };

    snTriggers.prototype.switcherSide = function() {
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
    };

    snTriggers.prototype.spoiler = function(elem) {
      if (elem == null) {
        elem = 'body';
      }
      console.log('trigger: ' + 'spoiler');
      return $(elem).find('.spoiler-caption').on('click', function(e) {
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
    };

    return snTriggers;

  })();
});
