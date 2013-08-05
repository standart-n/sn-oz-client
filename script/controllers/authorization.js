var Backbone, RegistrationView, RememberView, SigninView;

Backbone = require('Backbone');

SigninView = require('SigninView');

RegistrationView = require('RegistrationView');

RememberView = require('RememberView');

module.exports = Backbone.Router.extend({
  routes: {
    'signin': 'routeSignin',
    'registration': 'routeRegistration',
    'remember': 'routeRemember'
  },
  initialize: function() {
    _.extend(this, Backbone.Events);
    this.signinView = new SigninView();
    this.registrationView = new RegistrationView();
    return this.rememberView = new RememberView();
  },
  routeSignin: function() {
    return this.signinView.open();
  },
  routeRegistration: function() {
    return this.registrationView.open();
  },
  routeRemember: function() {
    return this.rememberView.open();
  }
});
