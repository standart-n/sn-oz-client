
module 'Кнопки на верхней панели'

test 'Когда пользователь неавторизован', () ->

	toolbar = window.social.signinToolbar

	# делаем выход 
	window.location = '#logout'

	ok				!toolbar.$signin.isNone(),							'кнопка Вход активна'
	ok				!toolbar.$registration.isNone(),					'кнопка Регистрация активна'
	ok				!toolbar.$remember.isNone(),						'кнопка Вспомнить пароль активна'
	ok				toolbar.$logout.isNone(),							'кнопка Выход неактивна'

test 'После регистрации', () ->

	toolbar = window.social.signinToolbar

	# имитируем авторизацию
	window.authorization.registrationView.model.set('success',true)

	ok				toolbar.$signin.isNone(),							'кнопка Вход неактивна'
	ok				toolbar.$registration.isNone(),						'кнопка Регистрация неактивна'
	ok				toolbar.$remember.isNone(),							'кнопка Вспомнить пароль неактивна'
	ok				!toolbar.$logout.isNone(),							'кнопка Выход активна'
	