
###
Роутинг приложения
###

$ ->

	methods =
		init: (options = {}) ->
			def =
				href:'#autoload'

			# извлекаем путь, по которому был переход

			if typeof options isnt 'object'
				href = options
			else				
				$.extend true, def, options
				href = def.href
			
			if href isnt '#' and href.match(/#([a-zA-Z0-9\_\-]+)/)

				# парсинг адресной строки
				
				levels =
					one: href.match /#([a-zA-Z0-9\_\-]+)/, '$2'
					two: href.match /#[a-zA-Z0-9\_\-]+\/([a-zA-Z0-9\_\-]+)/, '$3'
					three: href.match /#[a-zA-Z0-9\_\-]+\/[a-zA-Z0-9\_\-]+\/([a-zA-Z0-9\_\-]+)/, '$4'
					anchor: href.match /\:([a-zA-Z0-9\_\-]+)/



				# выводим в логи

				console.info 'url: ' + href if console?
				console.info 'levels: ', levels if console?

				# роутинг

				if levels.one? and levels.one[1] isnt 'spoiler'
					switch levels.one[1]

						# при начальной загрузке приложения

						when 'autoload'
							$(this).snModels '#primary', file: 'main.html'
							$(this).snModels '#side', file: 'side_main.html'
							$(this).snTriggers 'switch', 'side', 'main'
							$(this).snTriggers 'links', 'bar'
							$(this).snTriggers 'links', 'side'
							$(this).snTriggers 'links', 'primary'
							$(this).snTriggers 'hover', 'bar'
							$(this).snTriggers 'hover', 'side'
							$(this).snTriggers 'plugins', '#primary'
							$(this).snTriggers 'plugins', '#side'
							window.sn.part = 'main'

							#$.each $.cookie(), $.removeCookie

						
						else
							
							# в других случаях

							if levels.two? and levels.three?

								# сохраняем в cookies последнюю ссылку, по которой был сделан переход, чтобы
								# проверить работают ли cookie при переходах между страницами

								$.cookie 'last_href', href, expires: 7


								# поднимаем экран в самый вверх

								$('html,body').animate scrollTop:0, 0
								
								# если нужно загрузить простую текстовую страницу

								if levels.two[1] is 'text' and levels.one[1] isnt window.sn.part


										# загрузка html

										$(this).snModels '#side', file: 'side_' + levels.one[1] + '.html'
										$(this).snModels '#primary', file: levels.three[1] + '.html'

										# включение триггеров

										$(this).snTriggers 'links', 'side'
										$(this).snTriggers 'links', 'primary'
										$(this).snTriggers 'switch', 'bar', levels.one[1]
										$(this).snTriggers 'switch', 'side', levels.three[1]
										$(this).snTriggers 'hover', 'side'
										$(this).snTriggers 'plugins', '#primary'
										$(this).snTriggers 'plugins', '#side'

									# если нужно отобразить какой то модуль

									else
										$(this).snModels '#primary', file: levels.three[1] + '.html'
										$(this).snTriggers 'links', 'primary'
										$(this).snTriggers 'switch', 'side', levels.three[1]
										$(this).snTriggers 'plugins', '#primary'

								window.sn.part = levels.one[1]
					
					$(this).snEvents 'anchor', levels # проверяем вызывались ли якоря

					$(this).click(levels) # событие click для запуска модулей

		
		# прокручиваем экран вниз если сработал якорь

		anchor: (levels) ->
			if levels.anchor?
				try
					if $('#anchor-' + levels.anchor[1]).length
						height = $('#anchor-' + levels.anchor[1]).offset().top-50
						if height
							if  $('#side-' + levels.anchor[1]).length
								$(this).snTriggers 'switchSide', 'link':levels.anchor[1]
							$('html,body').animate  scrollTop:height, 'slow'
				catch e
					console.error 'anchor', e if console?

	# инициализация

	$.fn.snEvents = (sn = {}) ->
		if methods[sn]
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			methods.init.apply @, arguments
			