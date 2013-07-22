
# Загрузка настроек

require('jquery')

snWiki = require('wiki')

module.exports = class snConf


	# автозагрузка
	
	constructor: (@options = {}) ->
		@main()
		@theme()
		@css()
		@js()
		@settings()
		@wiki()


	# загрузка главного конфига, 
	# в нем хранится информация о том какой регион и какую тему оформления нужно загрузить

	main: ->

		$.ajax
			url: 'conf/main.json'
			async: off
			dataType: 'json'
			success: (s) ->
				if s?
					console.log 'conf: ' + 'main.json'
					# заносим эти данные в глобальные переменные, т.к. очень часто используются
					$.extend window.sn, s if s.region? and s.theme?

	# загрузка информации о нужной теме оформления

	theme: ->

		$.ajax
			url: 'conf/themes.json'
			async: off
			dataType: 'json'
			success: (s) ->
				if s?
					console.log 'conf: ' + 'themes.json'
					if s[window.sn.theme.name]?
						$.extend window.sn.theme, s[window.sn.theme.name]
				

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


		$.ajax
			url: 'conf/settings.json'
			async: off
			dataType: 'json'
			success: (s) ->
				if s?
					console.log 'conf: ' + 'settings.json'
					window.sn.settings = s
				
	wiki: ->

		window.wiki = new snWiki
			images:
				url: window.sn.settings.paths.images.url + sn.region.name + '/'
			files:
				url: window.sn.settings.paths.files.url + sn.region.name + '/'
			gismeteo:
				url: window.sn.settings.paths.widgets.gismeteo.url + sn.region.name + '/'


