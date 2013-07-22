var CLayout, LayoutBar, LayoutFooter, LayoutMain;

LayoutBar = require('LayoutBar');

LayoutMain = require('LayoutMain');

LayoutFooter = require('LayoutFooter');

module.exports = CLayout = (function() {
  function CLayout() {
    this.layoutBar = new LayoutBar();
    this.layoutMain = new LayoutMain();
    this.layoutFooter = new LayoutFooter();
  }

  return CLayout;

})();
