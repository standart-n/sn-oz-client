
# Старт приложения

require('jquery')
require('cookie')
require('bootstrap')

snConf = 		require('conf')
snDesign = 		require('design')
snModels = 		require('models')
snLayout = 		require('layout')
snTriggers = 	require('triggers')
snEvents = 		require('events')

$ () ->

	if !window.console?
		window.console =
			info: () ->
			log: () ->
			error: () ->
			warn: () ->

	class snApp

		constructor: (@options = {}) ->

			@setup()
			@start()

		# начальное состояние объекта sn

		setup: () ->

			window.sn = 
				region:
					caption: 'unknow'
					name: 'unknow'
				theme:
					caption: 'unknow'
					name: 'unknow'

			window.conf = 		new snConf()
			window.design = 	new snDesign()
			window.models = 	new snModels()
			window.layout = 	new snLayout()
			window.triggers = 	new snTriggers()
			window.events = 	new snEvents()

		# запуск приложения

		start: () ->

			# отображение начальной страницы по событию #autoload

			console.log 'autoload...'
			window.events.get '#autoload'


	window.app = new snApp()

