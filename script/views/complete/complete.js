var Backbone;

Backbone = require('Backbone');

module.exports = Backbone.View.extend({
  defaults: {
    icons: true,
    tooltips: false,
    buttonGroups: false
  },
  initialize: function() {
    var _ref;
    _.defaults(this.options, this.defaults);
    if (this.options.tooltips) {
      this.tooltips();
    }
    if (this.options.buttonGroups) {
      this.buttonGroups();
    }
    if ((typeof navigator !== "undefined" && navigator !== null ? (_ref = navigator.userAgent) != null ? _ref.toLowerCase().indexOf('msie 6.0') : void 0 : void 0) > -1) {
      if (this.options.icons) {
        return this.icons();
      }
    }
  },
  icons: function() {
    return this.$el.find('[class^="icon-"],[class*=" icon-"]').each(function() {
      if (!$(this).hasClass('icon-xxx')) {
        return $(this).addClass('icon-xxx').css({
          'background-position-y': (parseInt($(this).css('background-position-y')) + 1).toString() + 'px'
        });
      }
    });
  },
  tooltips: function() {
    return this.$el.find('.tooltip-toggle').tooltip();
  },
  buttonGroups: function() {
    this.$el.find('.btn-group').parent().find('.btn-group:eq(0)').addClass('btn-group-first');
    return this.$el.find('.btn').parent().find('.btn:eq(0)').addClass('btn-first');
  }
});
