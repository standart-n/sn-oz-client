$(function() {
  return $(document).on('click', '.spoiler-caption', function(e) {
    e.preventDefault();
    if ($(this).hasClass('spoiler-open')) {
      $(this).removeClass('spoiler-open').addClass('spoiler-close');
    } else {
      $(this).removeClass('spoiler-close').addClass('spoiler-open');
    }
    return $(this).parent('.spoiler').children('.spoiler-body').each(function() {
      if ($(this).hasClass('spoiler-open')) {
        return $(this).removeClass('spoiler-open').addClass('spoiler-close').hide();
      } else {
        return $(this).removeClass('spoiler-close').addClass('spoiler-open').show();
      }
    });
  });
});
