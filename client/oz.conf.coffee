$ ->
	methods =
		
		init: (options = {}) ->
			$(this).ozConf('main')
			$(this).ozConf('theme')
			$(this).ozConf('css')
			$(this).ozConf('js')
			$(this).ozConf('settings')

		main: ->
			sn = $(this).data 'oz'
			$.ajax
				url: 'conf/main.json'
				async: false
				dataType: 'json'
				success: (s) ->
					$.extend sn, s
					$(this).data 'oz', sn

		theme: ->
			sn = $(this).data 'oz'
			$.ajax
				url: 'conf/themes.json'
				async: false
				dataType: 'json'
				success: (s) ->
					if s[sn.theme.name]
						$.extend sn.theme, s[sn.theme.name]
						sn.theme.enable = true
					else
						sn.theme.enable = false
					
					$(this).data 'oz', sn

		css: ->
			sn = $(this).data 'oz'
			if sn.theme.css
				$.each sn.theme.css, (i) ->
					head = document.getElementsByTagName('head')[0]
					link = document.createElement 'link'
					link.rel = 'stylesheet'
					link.type = 'text/css'
					link.href = this
					head.appendChild link

		js: ->
			sn = $(this).data 'oz'
			if sn.theme.js
				$.each sn.theme.js, (i) ->
					$.getScript @

		settings: ->

			#$(this).ozConf('design');

	$.fn.ozConf = (sn = {}) ->
		if methods[sn]
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			if typeof sn == 'object' || !sn
				methods.init.apply @, arguments
			else 
				$.error 'Метод ' + sn + ' не существует'
