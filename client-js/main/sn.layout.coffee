$ ->

	methods = 
		init: (options = {}) ->
			$(this).snModels elem: '#bar', layout: 'bar.html'
			$(this).snModels elem: '#main', layout: 'main.html'


	$.fn.snLayout = (sn = {}) ->
		if methods[sn]
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			methods.init.apply @, arguments

