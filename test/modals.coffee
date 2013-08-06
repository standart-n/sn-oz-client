
module 'Модальные окна'

asyncTest 'Проверяем окно с регистрацией', 3, () ->

	view = 				window.authorization.registrationView

	# делаем выход 
	window.location = '#logout'	

	ok					view.$modal.isNone(),								'форма скрыта'

	# вызываем окно
	window.location = '#registration'
	
	setTimeout () ->
		ok				!view.$modal.isNone(),								'форма открылась'

		view.$close.trigger('click')

		setTimeout () ->
				ok		view.$modal.isNone(),								'форма закрылась'
				start()
		, 10

	, 10



asyncTest 'Проверяем окно с авторизацией', 3, () ->

	view = 				window.authorization.signinView

	# делаем выход 
	window.location = '#logout'	

	ok					view.$modal.isNone(),								'форма скрыта'

	# вызываем окно
	window.location = '#signin'
	
	setTimeout () ->
		ok				!view.$modal.isNone(),								'форма открылась'

		view.$close.trigger('click')

		setTimeout () ->
				ok		view.$modal.isNone(),								'форма закрылась'
				start()
		, 10

	, 10



asyncTest 'Проверяем окно вспомнить пароль', 3, () ->

	view = 				window.authorization.rememberView

	# делаем выход 
	window.location = '#logout'	

	ok					view.$modal.isNone(),								'форма скрыта'

	# вызываем окно
	window.location = '#remember'
	
	setTimeout () ->
		ok				!view.$modal.isNone(),								'форма открылась'

		view.$close.trigger('click')

		setTimeout () ->
				ok		view.$modal.isNone(),								'форма закрылась'
				start()
		, 10

	, 10


		