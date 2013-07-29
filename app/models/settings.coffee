
# Settings

Backbone = require('Backbone')

module.exports = Backbone.Model.extend

	defaults:
		async: off
		type: 'json'
		
		conf:
			main: 		'conf/main.json'
			themes:	 	'conf/themes.json'
			settings: 	'conf/settings.json'

		region:
			caption: 'unknow'
			name: 'unknow'

		theme:
			caption: 'unknow'
			name: 'unknow'

		settings:
			paths: {}

	initialize: () ->
		this.main()
		this.theme()
		this.settings()

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
					console.log 'conf: ' + 'main.json'
					settings = 	_this.get('settings')
					$.extend settings, s 	if s?
					_this.set 
						settings: 	settings
