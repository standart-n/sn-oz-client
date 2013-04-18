$ ->

	methods =
		init: (options = {}) ->
			# nothing
			conlole.log 'design'


	$.fn.snDesign = (sn = {}) ->
		if methods[sn]
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			methods.init.apply @, arguments

