var Template;

Template = require('Template');

module.exports = Template.extend({
  path: 'content',
  ext: '.html',
  render: function() {
    var region;
    if (this.file != null) {
      region = window.sn.get('region').name;
      this.url = this.path + '/' + region + '/' + this.file;
      return this.template();
    }
  },
  data: function() {
    var result;
    return result = {
      region: window.sn.get('region'),
      theme: window.sn.get('theme')
    };
  }
});
