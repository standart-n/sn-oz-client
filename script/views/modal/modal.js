var Template;

Template = require('Template');

module.exports = Template.extend({
  events: {
    'submit .form': 'submit'
  },
  render: function() {
    return this.template();
  },
  open: function() {
    return this.show();
  },
  afterOpen: function() {
    return this.afterShow();
  },
  show: function() {
    this.$el.find('.modal').modal('show');
    this.$el.find('.modal').on('hide', function() {
      return window.app.navigate('#');
    });
    return this.afterShow();
  },
  afterShow: function() {}
});
