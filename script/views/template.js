var Backbone;

require('ejs');

Backbone = require('Backbone');

module.exports = Backbone.View.extend({
  ext: '.html',
  markup: false,
  template: function() {
    var text, _ref;
    if ((_ref = this.url) != null ? _ref.match(/[\w]*\/[\w]*\/[\w]*.html/) : void 0) {
      text = new EJS({
        url: this.url,
        ext: this.ext
      }).render(this.data());
      if (this.markup) {
        text = window.markup.render(text);
      }
      return this.$el.html(text);
    }
  }
});
