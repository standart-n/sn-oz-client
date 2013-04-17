$ ->

	methods =
		init: (options = {}) ->


		checkEnterForm: (options = {}) ->
			sn = $(this).data sn
			alert 'enter'
			console.info 'sn', sn
			false


	$.fn.snEnter = (sn = {}) ->
		if methods[sn]
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			if typeof sn == 'object' || !sn
				methods.init.apply @, arguments
			else 
				$.error 'Метод ' + sn + ' не существует'


