
$ ->

	methods =
		init: (options = {}) ->

			def =
				'content':{}
				'result':{}

			$.extend true, def, options

			$(this).data('oz', def)
			$(this).ozConf()
			$(this).ozLayout()
			$(this).ozEvents('href':'#autoload')
			
			sn = $(this).data 'oz'

	$.fn.oz = (sn = {}) ->
		if methods[sn]
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			if typeof sn == 'object' || !sn
				methods.init.apply @, arguments
			else 
				$.error 'Метод ' + sn + ' не существует'
