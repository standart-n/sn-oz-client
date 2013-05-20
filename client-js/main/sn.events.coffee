
###
Роутинг приложения
###

$ ->

	methods =
		init: (options = {}) ->
			def =
				href:'none'

			# извлекаем путь, по которому был переход

			if typeof sn isnt 'object'
				def.href = options
			else				
				$.extend true, def, options
			
			if def.href isnt '#' and def.href.match(/#(.*)/)

				# сохраняем в cookies последнюю ссылку, по которой был сделан переход, чтобы
				# проверить работают ли cookie при переходах между страницами

				$.cookie 'last_href', def.href, expires: 7


				# сохраняем cookies, когда человек переходит в раздел "контакты", 
				# чтобы в тестах проверить, сохраняются ли они при закрытии программы

				if def.href is '#main/text/contacts'
					$.cookie 'contacts', def.href, expires: 7

				# парсинг адресной строки
				
				sn = $(this).data 'sn'	
				sn.href = def.href + '/:'
				sn.levels =
					one: sn.href.replace /(.*)#(.*?)\/(.*)/, '$2'
					two: sn.href.replace /(.*)#(.*?)\/(.*?)\/(.*)/, '$3'
					three: sn.href.replace /(.*)#(.*?)\/(.*?)\/(.*?)\/(.*)/, '$4'
					anchor: sn.href.replace /(.*)\:(.*?)\/(.*)/, '$2'

				# выводим в логи

				console.info 'url: ' + sn.href if console?
				console.info 'levels: ', sn.levels if console?

				# роутинг

				if sn.levels.one? and sn.levels.one isnt 'spoiler'
					switch sn.levels.one

						# при начальной загрузке приложения

						when 'autoload'
							$(this).snModels 'primary', file: 'main.html'
							$(this).snModels 'side', file: 'main.html'
							$(this).snTriggers 'switch', 'side', 'main'
							$(this).snTriggers 'links', 'bar'
							$(this).snTriggers 'links', 'side'
							$(this).snTriggers 'links', 'primary'
							$(this).snTriggers 'hover', 'bar'
							(this).snTriggers 'hover', 'side'
							sn.part = 'main'
						
						else
							
							# в других случаях

							if sn.levels.two? and sn.levels.three?

								# поднимаем экран в самый вверх

								$('html,body').animate scrollTop:0, 0
								
								# если нужно загрузить простую текстовую страницу

								if sn.levels.two is 'text'
									if sn.levels.one isnt sn.part


										# загрузка html

										$(this).snModels 'side', file: sn.levels.one + '.html'
										$(this).snModels 'primary', file: sn.levels.three + '.html'

										# включение триггеров

										$(this).snTriggers 'links', 'side'
										$(this).snTriggers 'links', 'primary'
										$(this).snTriggers 'switch', 'bar', sn.levels.one
										$(this).snTriggers 'switch', 'side', sn.levels.three
										$(this).snTriggers 'hover', 'side'

									# если нужно отобразить какой то модуль

									else
										$(this).snModels 'primary', file: sn.levels.three + '.html'
										$(this).snTriggers 'links', 'primary'
										$(this).snTriggers 'switch', 'side', sn.levels.three
			
								sn.part = sn.levels.one
					
					$(this).data 'sn', sn # пересохраняем sn

					$(this).snEvents 'anchor' # проверяем вызывались ли якоря

					$(this).click() # событие click для запуска модулей

		
		# прокручиваем экран вниз если сработал якорь

		anchor: (options = {}) ->
			sn = $(this).data 'sn'
			if sn.levels.anchor isnt ''
				try
					if $('#anchor-' + sn.levels.anchor).length
						height = $('#anchor-' + sn.levels.anchor).offset().top-87
						if height
							if  $('#side-' + sn.levels.anchor).length
								$(this).snTriggers 'switchSide', 'link':sn.levels.anchor
							$('html,body').animate  scrollTop:height, 'slow'
				catch e
					console.error 'anchor', e if console?

	# инициализация

	$.fn.snEvents = (sn = {}) ->
		if methods[sn]
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			methods.init.apply @, arguments
			