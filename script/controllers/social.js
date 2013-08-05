var Backbone, Self, SigninToolbar;

Backbone = require('Backbone');

Self = require('Self');

SigninToolbar = require('SigninToolbar');

module.exports = Backbone.Router.extend({
  routes: {
    'logout': 'routeLogout'
  },
  initialize: function() {
    var _this = this;
    _.extend(this, Backbone.Events);
    this.self = new Self();
    this.signinToolbar = new SigninToolbar();
    return this.listenTo(window.authorization.registrationView.model, 'change', function() {
      return _this.eventSignin(window.authorization.registrationView.model);
    });
  },
  eventSignin: function(model) {
    if (model.get('success') === true) {
      this.signinToolbar.signin();
      this.self.set('email', model.get('email'));
      this.self.set('key', model.get('password_hash'));
      this.self.set('firstname', model.get('firstname'));
      this.self.set('lastname', model.get('lastname'));
      this.self.set('company', model.get('company'));
      return this.self.set('signin', true);
    }
  },
  eventLogout: function() {
    this.signinToolbar.logout();
    return this.self.clear();
  }
});
