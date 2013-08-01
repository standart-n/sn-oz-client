var Backbone;

require('ejs');

Backbone = require('Backbone');

module.exports = Backbone.View.extend({
  ext: '.html',
  markup: false,
  template: function() {
    var text, _ref, _ref1, _ref2;
    if (this.url != null) {
      text = (_ref = new EJS({
        url: this.url,
        ext: this.ext,
        type: '['
      }).render(this.data())) != null ? _ref : '';
      if ((_ref1 = this.markup) != null ? _ref1 : '') {
        text = (_ref2 = window.markup) != null ? _ref2.render(text) : void 0;
      }
      return this.$el.html(text);
    }
  },
  render: function() {},
  data: function() {}
});
