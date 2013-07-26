var Complete, Template;

Template = require('Template');

Complete = require('Complete');

module.exports = Template.extend({
  path: 'content',
  ext: '.html',
  markup: true,
  render: function() {
    if (this.file != null) {
      this.beforeRender();
      this.region = window.sn.get('region').name;
      this.url = "" + this.path + "/" + this.region + "/" + this.file;
      this.template();
      return this.afterRender();
    }
  },
  data: function() {
    var result;
    return result = {
      region: window.sn.get('region'),
      theme: window.sn.get('theme')
    };
  },
  beforeRender: function() {},
  afterRender: function() {
    return new Complete({
      el: this.el,
      icons: true,
      tooltips: true
    });
  }
});
