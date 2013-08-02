var Layout;

Layout = require('Layout');

module.exports = Layout.extend({
  el: '#bar',
  file: 'bar.html',
  initialize: function() {
    return this.render();
  }
});
