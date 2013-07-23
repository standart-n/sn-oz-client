var Backbone;

Backbone = require('backbone');

module.exports = Backbone.Router.extend({
  routes: {
    'main/text/apteki': 'apteki'
  },
  initialize: function() {
    return alert('router');
  },
  apteki: function() {
    return alert('apteki');
  }
});
