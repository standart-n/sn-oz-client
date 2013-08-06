
# Старт приложения

require('jquery')
require('bootstrap')
require('json2')

Backbone = 								require('Backbone')
App = 									require('App')
Authorization = 						require('Authorization')
Social = 								require('Social')
Settings = 								require('Settings')
Markup = 								require('Markup')

$ () ->

	if !window.console?
		window.console = 
			info: () ->
			log: () ->
			error: () ->
			warn: () ->

	$.fn.isNone = () -> 
		$(this).css('display') is 'none'

	$.fn.shown = () -> 
		if $(this).hasClass('hide')
			$(this).removeClass('hide')
		else
			$(this).show()

	Backbone.emulateHTTP = on
	Backbone.emulateJSON = on

	window.sn = 						new Settings()

	window.markup = 					new Markup
		images:
			url: window.sn.get('settings').paths.images.url + window.sn.get('region').name + '/'
		files:
			url: window.sn.get('settings').paths.files.url + window.sn.get('region').name + '/'
		gismeteo:
			url: window.sn.get('settings').paths.widgets.gismeteo.url + window.sn.get('region').name + '/'

	window.app = 						new App()
	window.authorization = 				new Authorization()
	window.social = 					new Social()

	Backbone.history.start()
