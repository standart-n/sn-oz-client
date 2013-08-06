
# Settings

Backbone = require('Backbone')

module.exports = Backbone.Model.extend

	defaults:
		async: off
		type: 'json'
		
		conf:
			main: 		'conf/main.json'
			themes:	 	'conf/themes.json'
			server: 	'conf/server.json'
			settings: 	'conf/settings.json'

		region:
			caption: 'unknow'
			name: 'unknow'

		theme:
			caption: 'unknow'
			name: 'unknow'

		settings:
			paths: {}

		server:
			host: ''

	initialize: () ->
		this.main()
		this.theme()
		this.settings()
		this.server()

	main: () ->
		_this = this	
		$.ajax
			url: 		this.get('conf').main
			async: 		this.get('async')
			dataType: 	this.get('type')
			success: (s) ->
				if s?
					console.log 'conf: ' + 'main.json'
					region = 	_this.get('region')
					theme = 	_this.get('theme')
					$.extend region, s.region 	if s.region?
					$.extend theme, s.theme 	if s.theme?
					_this.set 
						region: 	region
						theme: 		theme

	theme: () ->
		_this = this
		$.ajax
			url: 		this.get('conf').themes
			async: 		this.get('async')
			dataType: 	this.get('type')
			success: (s) ->
				if s?
					console.log 'conf: ' + 'themes.json'
					theme = 	_this.get('theme')
					if s[theme.name]?
						$.extend theme, s[theme.name]
						_this.set 
							theme: 		theme

	settings: () ->
		_this = this
		$.ajax
			url: 		this.get('conf').settings
			async: 		this.get('async')
			dataType: 	this.get('type')
			success: (s) ->
				if s?
					console.log 'conf: ' + 'settings.json'
					settings = 	_this.get('settings')
					$.extend settings, s 	if s?
					_this.set 
						settings: 	settings

	server: () ->
		_this = this
		$.ajax
			url: 		this.get('conf').server
			async: 		this.get('async')
			dataType: 	this.get('type')
			success: (s) ->
				if s?
					console.log 'conf: ' + 'server.json'
					server = 	_this.get('server')
					$.extend server, s 	if s?
					_this.set 
						server: 	server
