
module 'Авторизация и регистрация'

test 'Начальное положение', () ->

	toolbar = window.social.signinToolbar
	
	if $.cookie('user_login')? and $.cookie('user_key')?

		# 
	else

		notEqual		toolbar.$signin.css('display'), 'none',				'кнопка Вход активна'
		notEqual		toolbar.$registration.css('display'), 'none', 		'кнопка Регистрация активна'
		notEqual		toolbar.$remember.css('display'), 'none',			'кнопка Вспомнить пароль активна'
		equal			toolbar.$logout.css('display'), 'none',				'кнопка Выход неактивна'


asyncTest 'Открываем форму с регистрацией', 2, () ->

	view = 				window.authorization.registrationView
	toolbar = 			window.social.signinToolbar

	#alert view.$modal.css('display')
	equal 				view.$modal.css('display'), 'none', 				'форма регистрации скрыта'

	# toolbar.$registration.trigger('click')
	window.location = '#registration'

	setTimeout () ->
		alert view.$modal.css('display')
		notEqual		view.$modal.css('display'), 'none', 				'форма регистрации появилась'
		start()
	, 100


	