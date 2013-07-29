var Backbone;

Backbone = require('Backbone');

module.exports = Backbone.Model.extend({
  defaults: {
    id: 10012,
    firstname: '',
    lastname: '',
    email: '',
    company: '123'
  },
  initialize: function() {}
});
