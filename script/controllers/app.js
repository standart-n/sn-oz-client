var Backbone, ContentPrimary, ContentSide, LayoutBar, LayoutFooter, LayoutMain, Signin;

Backbone = require('Backbone');

LayoutBar = require('LayoutBar');

LayoutMain = require('LayoutMain');

LayoutFooter = require('LayoutFooter');

ContentSide = require('ContentSide');

ContentPrimary = require('ContentPrimary');

Signin = require('Signin');

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
    return this.signin = new Signin();
  },
  text: function(part, page) {
    this.contentSide["switch"](part, page);
    return this.contentPrimary["switch"](part, page);
  }
});
