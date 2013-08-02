var Layout;

Layout = require('Layout');

module.exports = Layout.extend({
  el: '#footer',
  file: 'footer.html',
  initialize: function() {
    return this.render();
  }
});
