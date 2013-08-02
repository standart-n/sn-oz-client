var Modal, Registration, RegistrationAlertError, RegistrationAlertSuccess;

Modal = require('Modal');

Registration = require('Registration');

RegistrationAlertSuccess = require('RegistrationAlertSuccess');

RegistrationAlertError = require('RegistrationAlertError');

module.exports = Modal.extend({
  el: '#registration',
  url: 'view/registration/registration.html',
  model: new Registration(),
  initialize: function() {
    this.render();
    this.$firstname = this.$el.find('.registration-firstname');
    this.$lastname = this.$el.find('.registration-lastname');
    this.$email = this.$el.find('.registration-email');
    this.$company = this.$el.find('.registration-company');
    this.alertSuccess = new RegistrationAlertSuccess();
    return this.alertError = new RegistrationAlertError();
  },
  data: function() {
    return this.model.toJSON();
  },
  checking: function() {
    if (this.model.get('success')) {
      this.alertSuccess.show();
      return this.alertError.hide();
    } else {
      this.alertError.show(this.model.get('err'));
      return this.alertSuccess.hide();
    }
  },
  submit: function(e) {
    var _this = this;
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
        return _this.checking();
      }
    });
  }
});
