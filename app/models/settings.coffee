
# Settings

Backbone = require('backbone')

module.exports = Backbone.Model.extend

	defaults:
		async: off
		type: 'json'
		
		conf:
			main: 		'conf/main.json'
			themes:	 	'conf/themes.json'

		region:
			caption: 'unknow'
			name: 'unknow'
		theme:
			caption: 'unknow'
			name: 'unknow'

	initialize: () ->
		this.main()
		this.theme()


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


