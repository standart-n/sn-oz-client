var Backbone, BootstrapButtons, ContentPrimary, ContentSide, LayoutBar, LayoutFooter, LayoutMain, Signin, Spoiler;

Backbone = require('Backbone');

LayoutBar = require('LayoutBar');

LayoutMain = require('LayoutMain');

LayoutFooter = require('LayoutFooter');

ContentSide = require('ContentSide');

ContentPrimary = require('ContentPrimary');

Signin = require('Signin');

Spoiler = require('Spoiler');

BootstrapButtons = require('BootstrapButtons');

module.exports = Backbone.Router.extend({
  routes: {
    ':part/text/:page': 'text'
  },
  initialize: function() {
    this.layoutBar = new LayoutBar();
    this.layoutMain = new LayoutMain();
    this.layoutFooter = new LayoutFooter();
    this.contentSide = new ContentSide();
    this.contentPrimary = new ContentPrimary();
    this.signin = new Signin();
    new BootstrapButtons();
    return new Spoiler();
  },
  text: function(part, page) {
    this.contentSide["switch"](part, page);
    return this.contentPrimary["switch"](part, page);
  }
});
