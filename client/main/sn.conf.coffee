$ ->
	methods =
		
		init: (options = {}) ->
			$(this).snConf 'main'
			$(this).snConf 'theme'
			$(this).snConf 'css'
			$(this).snConf 'js'
			$(this).snConf 'settings'

		main: ->

			sn = $(this).data 'sn'
			console.log 'conf: ' + 'main.json' if console?

			$.ajax
				url: 'conf/main.json'
				async: off
				dataType: 'json'
				success: (s) ->
					$.extend sn, s
					$(this).data 'sn', sn

		theme: ->

			sn = $(this).data 'sn'
			console.log 'conf: ' + 'themes.json' if console?

			$.ajax
				url: 'conf/themes.json'
				async: off
				dataType: 'json'
				success: (s) ->
					if s[sn.theme.name]
						$.extend sn.theme, s[sn.theme.name]
						sn.theme.enable = on
					else
						sn.theme.enable = off
					
					$(this).data 'sn', sn

		css: ->

			sn = $(this).data 'sn'
			console.log 'conf: ' + 'css' if console?

			if sn.theme.css
				$.each sn.theme.css, (i) ->
					head = document.getElementsByTagName('head')[0]
					link = document.createElement 'link'
					link.rel = 'stylesheet'
					link.type = 'text/css'
					link.href = this
					head.appendChild link

		js: ->

			sn = $(this).data 'sn'
			console.log 'conf: ' + 'js' if console?

			if sn.theme.js
				$.each sn.theme.js, (i) ->
					$.getScript @

		settings: ->

			#$(this).snConf('design');

	$.fn.snConf = (sn = {}) ->
		if methods[sn]
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			methods.init.apply @, arguments
