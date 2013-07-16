module('Чтение и запись cookies');

$('.removeCookies').on('click', function(e) {
  return $.each($.cookie(), $.removeCookie);
});

test('чтение и запись простых значений', function() {
  $.removeCookie('test');
  $.cookie('test', 'go', {
    expires: 7
  });
  strictEqual($.cookie('test'), 'go', 'запись простого значения');
  $.removeCookie('test');
  return strictEqual($.cookie('test'), null, 'удаление простого значения');
});

test('запись cookies после перехода по страницам', function() {
  $.removeCookie('last_href');
  $('#sn').snEvents('#main/text/main');
  return ok($.cookie('last_href'), 'last_href');
});

module('Проверка глобальные переменных');

test('наличие window.sn', function() {
  var _ref, _ref1, _ref2, _ref3;
  ok(window.sn != null, 'window.sn');
  ok((((_ref = window.sn.region) != null ? _ref.name : void 0) != null) && window.sn.region.name !== 'unknow', 'window.sn.region.name');
  ok((((_ref1 = window.sn.region) != null ? _ref1.caption : void 0) != null) && window.sn.region.caption !== 'unknow', 'window.sn.region.caption');
  ok((((_ref2 = window.sn.theme) != null ? _ref2.name : void 0) != null) && window.sn.theme.name !== 'unknow', 'window.sn.theme.name');
  return ok((((_ref3 = window.sn.theme) != null ? _ref3.caption : void 0) != null) && window.sn.theme.caption !== 'unknow', 'window.sn.theme.caption');
});

module('Проверка целостности пакета');

test('наличие необходимых библиотек', function() {
  ok(window.jQuery != null, 'jQuery');
  ok(window.EJS != null, 'EJS');
  ok(window.jQuery.cookie != null, 'jquery.cookie');
  return ok(window.jQuery.isFunction($.bootstrapIE6) != null, 'bootstrap-ie6');
});

test('наличиние необходимых шаблонов и текстов', function() {
  ok($('#bar').html() !== '', 'layout/' + window.sn.region.name + '/bar.html');
  ok($('#main').html() !== '', 'layout/' + window.sn.region.name + '/main.html');
  ok($('#primary').html() !== '', 'content/' + window.sn.region.name + '/main.html');
  return ok($('#side').html() !== '', 'content/' + window.sn.region.name + '/side_main.html');
});
