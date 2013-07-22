var Backbone;

require('ejs');

Backbone = require('backbone');

module.exports = Backbone.View.extend({
  ext: '.html',
  template: function() {
    var _ref;
    if ((_ref = this.url) != null ? _ref.match(/[\w]*\/[\w]*\/[\w]*.html/) : void 0) {
      return this.$el.html(new EJS({
        url: this.url,
        ext: this.ext
      }).render(this.data()));
    }
  },
  data: function() {}
});
