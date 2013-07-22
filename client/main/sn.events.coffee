
# Роутинг приложения

require('jquery')
require('cookie')

module.exports = class snEvents

	constructor: () ->

	get: (options = {}) ->
		def =
			href:'#autoload'

		# извлекаем путь, по которому был переход

		if typeof options isnt 'object'
			href = options
		else				
			$.extend true, def, options
			href = def.href
		
		# strip for ie7
		href = href.replace(/.*(?=#[^\s]+$)/, '')

		if href isnt '#' and href.match(/#[a-zA-Z0-9\_\-]+/)

			# парсинг адресной строки
			
			levels = href.match /[a-zA-Z0-9\_\-]+/g

			# выводим в логи

			console.info 'url: ' + href
			console.info 'levels: ', levels

			# роутинг
	      
			if levels[0]? and levels[0] isnt 'spoiler'

				switch levels[0]

					# при начальной загрузке приложения

					when 'autoload'
						window.models.get '#primary', file: 'main.html'
						window.models.get '#side', file: 'side_main.html'
						window.triggers.switch 'side', 'main'
						window.triggers.links 'bar'
						window.triggers.links 'side'
						window.triggers.links 'primary'
						window.triggers.hover 'bar'
						window.triggers.hover 'side'
						window.triggers.plugins '#primary'
						window.triggers.plugins '#side'
						window.sn.part = 'main'

						#$.each $.cookie(), $.removeCookie

					
					else
						
						# в других случаях

						if levels[1]? and levels[2]?

							# сохраняем в cookies последнюю ссылку, по которой был сделан переход, чтобы
							# проверить работают ли cookie при переходах между страницами

							$.cookie 'last_href', href, expires: 7


							# поднимаем экран в самый вверх

							$('html,body').animate scrollTop: 0, 0
							
							# если нужно загрузить простую текстовую страницу

							if levels[1] is 'text' and levels[0] isnt window.sn.part


									# загрузка html

									window.models.get '#side', file: 'side_' + levels[0] + '.html'
									window.models.get '#primary', file: levels[2] + '.html'

									# включение триггеров

									window.triggers.links 'side'
									window.triggers.links 'primary'
									window.triggers.switch 'bar', levels[0]
									window.triggers.switch 'side', levels[2]
									window.triggers.hover 'side'
									window.triggers.plugins '#primary'
									window.triggers.plugins '#side'

								# если нужно отобразить какой то модуль

								else
									window.models.get '#primary', file: levels[2] + '.html'
									window.triggers.links 'primary'
									window.triggers.switch 'side', levels[2]
									window.triggers.plugins '#primary'

							window.sn.part = levels[0]
				
				# @anchor levels # проверяем вызывались ли якоря

				# $(this).click(levels) # событие click для запуска модулей

	
	# прокручиваем экран вниз если сработал якорь

	# anchor: (levels) ->
	# 	if levels.anchor?
	# 		try
	# 			if $('#anchor-' + levels.anchor[1]).length
	# 				height = $('#anchor-' + levels.anchor[1]).offset().top-50
	# 				if height
	# 					if  $('#side-' + levels.anchor[1]).length
	# 						window.triggers 'switchSide', 'link':levels.anchor[1]
	# 					$('html,body').animate  scrollTop:height, 'slow'
	# 		catch e
	# 			console.error 'anchor', e

