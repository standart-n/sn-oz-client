var Backbone;

Backbone = require('backbone');

module.exports = Backbone.View.extend({
  path: 'layout',
  ext: '.html',
  render: function() {
    var region, url;
    if (this.file != null) {
      region = window.sn.get('region').name;
      url = this.path + '/' + region + '/' + this.file;
      if (url.match(/[\w]*\/[\w]*\/[\w]*.html/)) {
        return this.$el.html(new EJS({
          url: url,
          ext: this.ext
        }).render(this.data()));
      }
    }
  },
  data: function() {
    var result;
    return result = {
      region: window.sn.get('region'),
      theme: window.sn.get('theme')
    };
  }
});
