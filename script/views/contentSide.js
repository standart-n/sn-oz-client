var Content;

require('jquery');

Content = require('Content');

module.exports = Content.extend({
  el: '#side',
  file: 'side_main.html',
  initialize: function() {
    return this.render();
  },
  "switch": function(part, page) {
    if (this.file !== ("side_" + part + ".html")) {
      this.file = "side_" + part + ".html";
      this.render();
    }
    return this.$el.find('.nav').find('li').each(function() {
      if ($(this).find('a').attr('href').match("" + part + "/text/" + page)) {
        return $(this).addClass('active');
      } else {
        return $(this).removeClass('active');
      }
    });
  }
});
