var Complete, Template;

Template = require('Template');

Complete = require('Complete');

module.exports = Template.extend({
  path: 'layout',
  markup: false,
  render: function() {
    var _ref, _ref1;
    if ((this.file != null) && (this.path != null)) {
      this.beforeRender();
      this.region = (_ref = (_ref1 = window.sn) != null ? _ref1.get('region').name : void 0) != null ? _ref : '';
      this.url = "" + this.path + "/" + this.region + "/" + this.file;
      this.template();
      return this.afterRender();
    }
  },
  data: function() {
    var result;
    return result = {
      region: window.sn.get('region'),
      theme: window.sn.get('region')
    };
  },
  beforeRender: function() {},
  afterRender: function() {
    return new Complete({
      el: this.el,
      icons: true
    });
  }
});
