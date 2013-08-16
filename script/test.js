module('Модальные окна');

asyncTest('Проверяем окно с регистрацией', 3, function() {
  var view;
  view = window.authorization.registrationView;
  window.location = '#logout';
  ok(view.$modal.isNone(), 'форма скрыта');
  window.location = '#registration';
  return setTimeout(function() {
    ok(!view.$modal.isNone(), 'форма открылась');
    view.$close.trigger('click');
    return setTimeout(function() {
      ok(view.$modal.isNone(), 'форма закрылась');
      return start();
    }, 10);
  }, 10);
});

asyncTest('Проверяем окно с авторизацией', 3, function() {
  var view;
  view = window.authorization.signinView;
  window.location = '#logout';
  ok(view.$modal.isNone(), 'форма скрыта');
  window.location = '#signin';
  return setTimeout(function() {
    ok(!view.$modal.isNone(), 'форма открылась');
    view.$close.trigger('click');
    return setTimeout(function() {
      ok(view.$modal.isNone(), 'форма закрылась');
      return start();
    }, 10);
  }, 10);
});

asyncTest('Проверяем окно вспомнить пароль', 3, function() {
  var view;
  view = window.authorization.rememberView;
  window.location = '#logout';
  ok(view.$modal.isNone(), 'форма скрыта');
  window.location = '#remember';
  return setTimeout(function() {
    ok(!view.$modal.isNone(), 'форма открылась');
    view.$close.trigger('click');
    return setTimeout(function() {
      ok(view.$modal.isNone(), 'форма закрылась');
      return start();
    }, 10);
  }, 10);
});

module('Кнопки на верхней панели');

asyncTest('Когда пользователь неавторизован', 4, function() {
  window.location = '#logout';
  return setTimeout(function() {
    var toolbar;
    toolbar = window.authorization.signinToolbar;
    ok(!toolbar.$signin.isNone(), 'кнопка Вход активна');
    ok(!toolbar.$registration.isNone(), 'кнопка Регистрация активна');
    ok(!toolbar.$remember.isNone(), 'кнопка Вспомнить пароль активна');
    ok(toolbar.$logout.isNone(), 'кнопка Выход неактивна');
    return start();
  }, 1);
});

asyncTest('После авторизации', 4, function() {
  window.user.set('signin', true);
  return setTimeout(function() {
    var toolbar;
    toolbar = window.authorization.signinToolbar;
    ok(toolbar.$signin.isNone(), 'кнопка Вход неактивна');
    ok(toolbar.$registration.isNone(), 'кнопка Регистрация неактивна');
    ok(toolbar.$remember.isNone(), 'кнопка Вспомнить пароль неактивна');
    ok(!toolbar.$logout.isNone(), 'кнопка Выход активна');
    return start();
  }, 1);
});
