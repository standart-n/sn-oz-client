
# Старт приложения

require('jquery')
require('bootstrap')
require('json2')
require('moment')
require('moment-ru')

Backbone = 								require('Backbone')
App = 									require('App')
User = 		 							require('User')
Authorization = 						require('Authorization')
Profile = 								require('Profile')
News = 									require('News')
Settings = 								require('Settings')
Markup = 								require('Markup')

$ () ->

	if !window.console?
		window.console = 
			info: () ->
			log: () ->
			error: () ->
			warn: () ->

	window.jalert = (s) ->
		alert JSON.stringify(s)

	$.fn.isNone = () -> 
		$(this).css('display') is 'none'

	$.fn.shown = () -> 
		if $(this).hasClass('hide')
			$(this).removeClass('hide')
		else
			$(this).show()

	Backbone.emulateHTTP = on
	Backbone.emulateJSON = on

	moment.lang('ru')

	window.sn = 						new Settings()

	window.markup = 					new Markup
		images:
			url: window.sn.get('settings').paths.images.url + window.sn.get('region').name + '/'
		files:
			url: window.sn.get('settings').paths.files.url + window.sn.get('region').name + '/'
		gismeteo:
			url: window.sn.get('settings').paths.widgets.gismeteo.url + window.sn.get('region').name + '/'

	window.user = 						new User()

	window.app = 						new App()
	window.authorization = 				new Authorization()
	window.profile = 					new Profile()
	window.news = 						new News()

	Backbone.history.start()
