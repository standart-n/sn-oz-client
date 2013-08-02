var Template;

Template = require('Template');

module.exports = Template.extend({
  el: '.registration-alert-success',
  url: 'view/registration/alertSuccess.html',
  initialize: function() {},
  render: function() {
    return this.template();
  },
  show: function() {
    this.$el.show();
    return this.render();
  },
  hide: function() {
    this.$el.hide();
    return this.render();
  },
  data: function() {}
});
