var snLayout;

module.exports = snLayout = (function() {
  function snLayout(options) {
    this.options = options != null ? options : {};
    window.models.get('#bar', {
      layout: 'bar.html',
      wiki: false
    });
    window.models.get('#main', {
      layout: 'main.html',
      wiki: false
    });
  }

  return snLayout;

})();
