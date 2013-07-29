var Modal;

Modal = require('Modal');

module.exports = Modal.extend({
  el: '#signin',
  url: 'view/signin/signin.html',
  initialize: function() {
    return this.render();
  },
  submit: function(e) {
    return e.preventDefault();
  }
});
