$ ->

	methods = 
		init: (options = {}) ->
			$(this).snModels 'main', layout: 'main.html'


	$.fn.snLayout = (sn = {}) ->
		if methods[sn]
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			methods.init.apply @, arguments

