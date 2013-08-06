
module 'Кнопки на верхней панели'

asyncTest 'Когда пользователь неавторизован', 4, () ->

	# делаем выход 
	window.location = '#logout'

	setTimeout () ->

		toolbar = window.social.signinToolbar
		ok				!toolbar.$signin.isNone(),							'кнопка Вход активна'
		ok				!toolbar.$registration.isNone(),					'кнопка Регистрация активна'
		ok				!toolbar.$remember.isNone(),						'кнопка Вспомнить пароль активна'
		ok				toolbar.$logout.isNone(),							'кнопка Выход неактивна'
		start()

	, 1

asyncTest 'После регистрации', 4, () ->

	# имитируем авторизацию
	window.location = '#'
	window.authorization.registrationView.model.set('success',true)

	setTimeout () ->

		toolbar = window.social.signinToolbar
		ok				toolbar.$signin.isNone(),							'кнопка Вход неактивна'
		ok				toolbar.$registration.isNone(),						'кнопка Регистрация неактивна'
		ok				toolbar.$remember.isNone(),							'кнопка Вспомнить пароль неактивна'
		ok				!toolbar.$logout.isNone(),							'кнопка Выход активна'
		start()

	, 1

asyncTest 'Еще раз выходим', 4, () ->

	# делаем выход 
	window.location = '#logout'

	setTimeout () ->

		toolbar = window.social.signinToolbar
		ok				!toolbar.$signin.isNone(),							'кнопка Вход активна'
		ok				!toolbar.$registration.isNone(),					'кнопка Регистрация активна'
		ok				!toolbar.$remember.isNone(),						'кнопка Вспомнить пароль активна'
		ok				toolbar.$logout.isNone(),							'кнопка Выход неактивна'
		start()

	, 1
	

asyncTest 'После авторизации', 4, () ->

	# имитируем авторизацию
	window.authorization.signinView.model.set('success',true)

	setTimeout () ->

		toolbar = window.social.signinToolbar
		ok				toolbar.$signin.isNone(),							'кнопка Вход неактивна'
		ok				toolbar.$registration.isNone(),						'кнопка Регистрация неактивна'
		ok				toolbar.$remember.isNone(),							'кнопка Вспомнить пароль неактивна'
		ok				!toolbar.$logout.isNone(),							'кнопка Выход активна'
		start()

	, 1


	