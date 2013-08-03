var Modal, Registration, RegistrationAlertError, RegistrationAlertSuccess, RegistrationTextSuccess;

Modal = require('Modal');

Registration = require('Registration');

RegistrationAlertSuccess = require('RegistrationAlertSuccess');

RegistrationAlertError = require('RegistrationAlertError');

RegistrationTextSuccess = require('RegistrationTextSuccess');

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
    this.$form = this.$el.find('.registration-form');
    this.alertSuccess = new RegistrationAlertSuccess();
    this.alertError = new RegistrationAlertError();
    return this.textSuccess = new RegistrationTextSuccess();
  },
  afterShow: function() {
    this.alertSuccess.hide();
    this.alertError.hide();
    this.textSuccess.hide();
    return this.$form.show();
  },
  data: function() {
    return this.model.toJSON();
  },
  checking: function() {
    if (this.model.get('success')) {
      this.$form.hide();
      this.alertSuccess.show();
      this.alertError.hide();
      return this.textSuccess.show({
        email: this.model.get('email'),
        password: this.model.get('password')
      });
    } else {
      this.alertError.show(this.model.get('err'));
      this.alertSuccess.hide();
      this.textSuccess.hide();
      return this.$form.show();
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
