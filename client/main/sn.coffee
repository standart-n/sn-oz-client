
###
Старт приложения
----------------
###

$ ->
	methods =
		init: (options = {}) ->

			$(this).sn 'setup', options
			$(this).sn 'start'



		# начальное состояние объекта sn

		setup: (options = {}) ->

			window.sn = 
				region:
					caption: 'unknow'
					name: 'unknow'
				theme:
					caption: 'unknow'
					name: 'unknow'

			sn =
				levels:{} # состояние последнего перехода
				users:{} # состояние пользователя
				content:{}
				conf: {}
				result:{} # результат последнего ajax запроса
				theme:{} # тема оформления
				settings:{} # доп. настройки

			$.extend true, sn, options
			$(this).data 'sn', sn

			sn


		# запуск приложения

		start: (options = {}) ->

			# загрузка конфигов

			console.log 'configuration...' if console?
			$(this).snConf()


			# загрузка оболочки и дизайна

			console.log 'layout...' if console?
			$(this).snLayout()


			# отображение начальной страницы по событию #autoload

			console.log 'autoload...' if console?
			$(this).snEvents '#autoload'




	# инициализация 

	$.fn.sn = (sn = {}) ->
		if methods[sn]
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			methods.init.apply @, arguments

