var Content;

Content = require('Content');

module.exports = Content.extend({
  el: '#primary',
  file: 'main.html',
  initialize: function() {
    return this.render();
  },
  "switch": function(part, page) {
    this.file = "" + page + ".html";
    return this.render();
  }
});
