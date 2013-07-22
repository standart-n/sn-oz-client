var Layout;

Layout = require('Layout');

module.exports = Layout.extend({
  el: '#main',
  file: 'main.html',
  initialize: function() {
    return this.render();
  }
});
