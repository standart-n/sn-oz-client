
$ ->

	methods =
		init: (options = {}) ->

			sn =
				levels:{}
				users:{}
				content:{}
				result:{}
				console: off

			$.extend true, sn, options

			$(this).data 'sn', sn
			console.log 'configuration...' if console?
			$(this).snConf()
			console.log 'layout...' if console?
			$(this).snLayout()
			console.log 'autoload...' if console?
			$(this).snEvents '#autoload'



	$.fn.sn = (sn = {}) ->
		if methods[sn]
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			methods.init.apply @, arguments
