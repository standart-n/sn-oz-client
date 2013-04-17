
$ ->

	methods =
		init: (options = {}) ->

			def =
				levels:{}
				users:{}
				content:{}
				result:{}

			$.extend true, def, options

			console.log 'start...'
			$(this).data 'sn', def
			console.log 'configuration...'
			$(this).snConf()
			console.log 'layout...'
			$(this).snLayout()
			console.log 'autoload...'
			$(this).snEvents href: '#autoload'


	$.fn.sn = (sn = {}) ->
		if methods[sn]
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			if typeof sn == 'object' || !sn
				methods.init.apply @, arguments
			else 
				$.error 'Метод ' + sn + ' не существует'
