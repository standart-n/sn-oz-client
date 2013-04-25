$ ->

	methods =
		init: (options = {}) ->
			# nothing
			conlole.log 'design' if console?


	$.fn.snDesign = (sn = {}) ->
		if methods[sn]
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			methods.init.apply @, arguments

