
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

			sn =
				levels:{} # состояние последнего перехода
				users:{} # состояние пользователя
				content:{}
				conf: {}
				result:{} # результат последнего ajax запроса
				theme:{} # тема оформления
				settings:{} # доп. настройки
				execute:
					conf: true
					layout: true
					events: true


			$.extend true, sn, options
			$(this).data 'sn', sn

			sn


		# запуск приложения

		start: (options = {}) ->

			sn = $(this).data 'sn'

			# загрузка конфигов

			if sn.execute.conf
				console.log 'configuration...' if console?
				$(this).snConf()


			# загрузка оболочки и дизайна

			if sn.execute.layout
				console.log 'layout...' if console?
				$(this).snLayout()


			# отображение начальной страницы по событию #autoload

			if sn.execute.events
				console.log 'autoload...' if console?
				$(this).snEvents '#autoload'




	# инициализация 

	$.fn.sn = (sn = {}) ->
		if methods[sn]
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			methods.init.apply @, arguments

