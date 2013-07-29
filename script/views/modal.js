var Template;

Template = require('Template');

module.exports = Template.extend({
  events: {
    'submit .form': 'submit',
    'click .modal-close': 'close'
  },
  render: function() {
    return this.template();
  },
  open: function() {
    return this.show();
  },
  show: function() {
    return this.$el.find('.modal').modal('show');
  },
  close: function() {
    return this.hide();
  },
  hide: function() {
    return this.$el.find('.modal').modal('hide');
  }
});
