var Template;

Template = require('Template');

module.exports = Template.extend({
  el: '.registration-alert-error',
  url: 'view/registration/alertError.html',
  initialize: function() {},
  render: function() {
    return this.template();
  },
  show: function(err) {
    this.err = err;
    switch (err.field) {
      case "firstname":
        this.err.field = "Имя";
        break;
      case "lastname":
        this.err.field = "Фамилия";
        break;
      case "company":
        this.err.field = "Компания";
        break;
      case "email":
        this.err.field = "e-mail";
    }
    this.$el.show();
    return this.render();
  },
  hide: function() {
    this.$el.hide();
    return this.render();
  },
  data: function() {
    var result;
    return result = {
      field: this.err.field,
      description: this.err.description
    };
  }
});
