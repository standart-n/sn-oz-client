var Modal, Registration;

Modal = require('Modal');

Registration = require('Registration');

module.exports = Modal.extend({
  el: '#registration',
  url: 'view/registration/registration.html',
  model: new Registration(),
  initialize: function() {
    return this.render();
  },
  submit: function(e) {
    e.preventDefault();
    return this.model.save({}, {
      url: '//dev.st-n.ru',
      error: function() {
        return alert('error');
      },
      dataType: 'jsonp'
    });
  }
});
