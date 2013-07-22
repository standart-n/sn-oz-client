
# Старт приложения

require('jquery')
require('cookie')
require('bootstrap')
require('underscore')
require('json2')


CConsole = 			require('CConsole')
CLayout = 			require('CLayout')
Settings = 			require('Settings')
ContentSide =  		require('ContentSide')


class App

	constructor: () ->

		window.console = 	new CConsole() if !window.console?
		window.sn = 		new Settings()
		@layout = 			new CLayout()	

$ () ->

	window.app = new App()
	new ContentSide().render()



