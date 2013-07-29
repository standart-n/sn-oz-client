var Backbone, BootstrapButtons, ContentPrimary, ContentSide, LayoutBar, LayoutFooter, LayoutMain, RegistrationView, RememberView, SigninView, Spoiler;

Backbone = require('Backbone');

LayoutBar = require('LayoutBar');

LayoutMain = require('LayoutMain');

LayoutFooter = require('LayoutFooter');

ContentSide = require('ContentSide');

ContentPrimary = require('ContentPrimary');

SigninView = require('SigninView');

RegistrationView = require('RegistrationView');

RememberView = require('RememberView');

Spoiler = require('Spoiler');

BootstrapButtons = require('BootstrapButtons');

module.exports = Backbone.Router.extend({
  routes: {
    ':part/text/:page': 'routeText',
    'signin': 'routeSignin',
    'registration': 'routeRegistration',
    'remember': 'routeRemember'
  },
  initialize: function() {
    this.layoutBar = new LayoutBar();
    this.layoutMain = new LayoutMain();
    this.layoutFooter = new LayoutFooter();
    this.contentSide = new ContentSide();
    this.contentPrimary = new ContentPrimary();
    this.signinView = new SigninView();
    this.registrationView = new RegistrationView();
    this.rememberView = new RememberView();
    new BootstrapButtons();
    return new Spoiler();
  },
  routeText: function(part, page) {
    this.contentSide["switch"](part, page);
    return this.contentPrimary["switch"](part, page);
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
