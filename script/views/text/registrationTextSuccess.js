var Template;

Template = require('Template');

module.exports = Template.extend({
  el: '.registration-text-success',
  url: 'view/registration/textSuccess.html',
  initialize: function() {},
  render: function() {
    return this.template();
  },
  show: function(res) {
    this.res = res;
    this.$el.show();
    return this.render();
  },
  hide: function() {
    return this.$el.hide();
  },
  data: function() {
    return this.res;
  }
});
