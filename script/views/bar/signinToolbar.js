var Backbone;

Backbone = require('Backbone');

module.exports = Backbone.View.extend({
  el: '#bar',
  initialize: function() {
    this.$signin = this.$el.find('bar-signin');
    this.$logout = this.$el.find('bar-logout');
    this.$registration = this.$el.find('bar-signin');
    return this.$remember = this.$el.find('bar-remember');
  },
  signin: function() {
    this.$logout.show();
    this.$signin.hide();
    this.$registration.hide();
    return this.$remember.hide();
  },
  logout: function() {
    this.$logout.hide();
    this.$signin.show();
    this.$registration.show();
    return this.$remember.show();
  }
});
