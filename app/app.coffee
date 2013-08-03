
# Старт приложения

require('jquery')
require('cookie')
require('bootstrap')
require('json2')

Backbone = 								require('Backbone')
App = 									require('App')
User = 									require('User')
Settings = 								require('Settings')
Markup = 								require('Markup')

if !window.console?
	window.console = 
		info: () ->
		log: () ->
		error: () ->
		warn: () ->

$ () ->

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
	window.user = 						new User()

	Backbone.history.start()
