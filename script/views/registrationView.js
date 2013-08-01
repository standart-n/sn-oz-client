var Modal, Registration;

Modal = require('Modal');

Registration = require('Registration');

module.exports = Modal.extend({
  el: '#registration',
  url: 'view/registration/registration.html',
  model: new Registration(),
  initialize: function() {
    this.render();
    this.$firstname = this.$el.find('.registration-firstname');
    this.$lastname = this.$el.find('.registration-lastname');
    this.$email = this.$el.find('.registration-email');
    return this.$company = this.$el.find('.registration-company');
  },
  data: function() {
    return this.model.toJSON();
  },
  submit: function(e) {
    e.preventDefault();
    return this.model.save({
      firstname: this.$firstname.val(),
      lastname: this.$lastname.val(),
      email: this.$email.val(),
      company: this.$company.val()
    }, {
      url: 'http://dev.st-n.ru/registration',
      dataType: 'jsonp',
      success: function(s) {
        alert(JSON.stringify(s));
        return alert(s.id);
      }
    });
  }
});
