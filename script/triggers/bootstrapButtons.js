var BootstrapButtons;

module.exports = BootstrapButtons = (function() {
  BootstrapButtons.prototype.options = {
    btnColorCls: ['btn-primary', 'btn-warning', 'btn-danger', 'btn-success', 'btn-info', 'btn-inverse', 'btn-link'],
    btnSizeCls: ['btn-mini', 'btn-small', 'btn-large']
  };

  function BootstrapButtons() {
    var _ref, _this;
    _this = this;
    if ((typeof navigator !== "undefined" && navigator !== null ? (_ref = navigator.userAgent) != null ? _ref.toLowerCase().indexOf('msie 6.0') : void 0 : void 0) > -1) {
      $(document).on('mouseenter', '.btn', function() {
        var hover, __this;
        __this = this;
        hover = 'btn-hover';
        $.each(_this.options.btnColorCls, function(k, v) {
          if ($(__this).hasClass(v)) {
            return hover = v + '-hover';
          }
        });
        $(this).data('ie6hover', hover);
        return $(this).addClass(hover);
      });
      $(document).on('mouseleave', '.btn', function() {
        var hover;
        hover = $(this).data('ie6hover');
        $(this).removeData('ie6hover', hover);
        if (hover) {
          return $(this).removeClass(hover);
        }
      });
    }
  }

  return BootstrapButtons;

})();
