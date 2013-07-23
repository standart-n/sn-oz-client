
# Старт приложения

require('jquery')
require('cookie')
require('bootstrap')
require('json2')

Backbone = 			require('backbone')
CConsole = 			require('CConsole')
Settings = 			require('Settings')
CLayout = 			require('CLayout')
ContentSide =  		require('ContentSide')
ContentPrimary =	require('ContentPrimary')
Router = 			require('Text')


class App

	constructor: () ->

		window.console = 	new CConsole() if !window.console?
		window.sn = 		new Settings()
		@layout = 			new CLayout()	

$ () ->

	window.app = new App()
	new ContentSide().render()
	new ContentPrimary().render()
	router = new Router()
	Backbone.history.start()
	# router.navigate('#main/text/apteki')




