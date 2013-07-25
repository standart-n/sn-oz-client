var Template;

Template = require('Template');

module.exports = Template.extend({
  path: 'content',
  ext: '.html',
  markup: true,
  render: function() {
    var region;
    if (this.file != null) {
      this.beforeRender();
      region = window.sn.get('region').name;
      this.url = "" + this.path + "/" + region + "/" + this.file;
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
    this.$el.find('.tooltip-toggle').tooltip();
    if ($.isFunction($.bootstrapIE6)) {
      return $.bootstrapIE6(this.el);
    }
  }
});
