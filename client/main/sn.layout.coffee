$ ->

	methods = 
		init: (options = {}) ->
			sn = $(this).data 'sn'
			main = new EJS(url: 'layout/' + sn.region.name + '/main.html', ext: '.html').render
				header:		new EJS(url: 'layout/' + sn.region.name + '/header.html', ext: '.html').render
					caption: sn.region.caption
				content:	new EJS(url: 'layout/' + sn.region.name + '/content.html', ext: '.html').render()
			$(this).snModels 'main', text: main


	$.fn.snLayout = (sn = {}) ->
		if methods[sn]
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			if typeof sn == 'object' || !sn
				methods.init.apply @, arguments
			else 
				$.error 'Метод ' + sn + ' не существует'

