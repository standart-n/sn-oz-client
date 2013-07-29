var Modal;

Modal = require('Modal');

module.exports = Modal.extend({
  el: '#remember',
  url: 'view/remember/remember.html',
  initialize: function() {
    return this.render();
  },
  submit: function(e) {
    return e.preventDefault();
  }
});
