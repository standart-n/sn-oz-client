var Backbone;

require('jquery');

Backbone = require('Backbone');

module.exports = Backbone.View.extend({
  el: '#signin',
  events: {
    'submit #signin-form': 'submit'
  },
  submit: function(e) {
    e.preventDefault();
    return alert('submit');
  }
});
