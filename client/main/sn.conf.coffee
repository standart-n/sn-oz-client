
###
Загрузка настроек
-----------------
###

$ ->
	$this =


		# автозагрузка
		
		init: (options = {}) ->
			$(this).snConf 'main'
			$(this).snConf 'theme'
			$(this).snConf 'css'
			$(this).snConf 'js'
			$(this).snConf 'settings'
			$(this).snConf 'wiki'


		# загрузка главного конфига, 
		# в нем хранится информация о том какой регион и какую тему оформления нужно загрузить

		main: ->

			sn = $(this).data 'sn'
			console.log 'conf: ' + 'main.json'

			$.ajax
				url: 'conf/main.json'
				async: off
				dataType: 'json'
				success: (s) ->
					if s?
						$.extend sn, s
						sn.conf.main = on

					# заносим эти данные в глобальные переменные, т.к. очень часто используются
					window.sn.region  = sn.region if sn.region?
					window.sn.theme  = sn.theme if sn.theme?

					$(this).data 'sn', sn


		# загрузка информации о нужной теме оформления

		theme: ->

			sn = $(this).data 'sn'
			console.log 'conf: ' + 'themes.json'

			$.ajax
				url: 'conf/themes.json'
				async: off
				dataType: 'json'
				success: (s) ->
					if s?
						sn.conf.theme = on
						if s[sn.theme.name]?
							$.extend sn.theme, s[sn.theme.name]
							sn.theme.enable = on
						else
							sn.theme.enable = off
					
						$(this).data 'sn', sn


		# загрузка css файлов для данной темы оформления, если они прописаны в theme.json
		# а не загружаются сразу в index.html

		css: ->

			console.log 'conf: ' + 'css'

			if window.sn.theme.css?
				$.each window.sn.theme.css, (i) ->
					head = document.getElementsByTagName('head')[0]
					link = document.createElement 'link'
					link.rel = 'stylesheet'
					link.type = 'text/css'
					link.href = this
					head.appendChild link


		# ajax загрузка необходимых скриптов для данной темы

		js: ->

			console.log 'conf: ' + 'js'

			if window.sn.theme.js?
				$.each window.sn.theme.js, (i) ->
					$.getScript @

		# другие настройки

		settings: ->

			sn = $(this).data 'sn'
			console.log 'conf: ' + 'settings.json'

			$.ajax
				url: 'conf/settings.json'
				async: off
				dataType: 'json'
				success: (s) ->
					if s?
						$.extend sn.settings, s
						sn.settings.enable = on
						sn.conf.settings = on
					
					$(this).data 'sn', sn

		wiki: ->

			sn = $(this).data 'sn'
			window.sn.wiki =
				images:
					url: sn.settings.paths.images.url + sn.region.name + '/'
				files:
					url: sn.settings.paths.files.url + sn.region.name + '/'
				gismeteo:
					url: sn.settings.paths.widgets.gismeteo.url + sn.region.name + '/'


	# инициализация

	$.fn.snConf = (sn = {}) ->
		if $this[sn]
			$this[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			$this.init.apply @, arguments

