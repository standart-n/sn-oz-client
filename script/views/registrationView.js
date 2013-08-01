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
      url: 'http://dev.st-n.ru/registration',
      dataType: 'jsonp',
      error: function() {
        return alert('error');
      },
      success: function(s) {
        alert(JSON.stringify(s));
        return alert(s.id);
      }
    });
  }
});
