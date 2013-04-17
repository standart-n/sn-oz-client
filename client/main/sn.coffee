
$ ->

	methods =
		init: (options = {}) ->

			def =
				levels:{}
				users:{}
				content:{}
				result:{}

			$.extend true, def, options

			$(this).data 'sn', def
			$(this).snConf()
			$(this).snLayout()
			$(this).snEvents('href':'#autoload')			


	$.fn.sn = (sn = {}) ->
		if methods[sn]
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			if typeof sn == 'object' || !sn
				methods.init.apply @, arguments
			else 
				$.error 'Метод ' + sn + ' не существует'
