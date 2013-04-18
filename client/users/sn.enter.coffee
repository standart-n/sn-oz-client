$ ->

	methods =
		init: (options = {}) ->


		checkEnterForm: (options = {}) ->

			console.log 'enter: ' + 'checkEnterForm'

			sn = $(this).data sn
			alert 'enter'
			console.info 'sn', sn
			false


	$.fn.snEnter = (sn = {}) ->
		if methods[sn]
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			methods.init.apply @, arguments


