$ ->

	methods = 
		init: (options = {}) ->
			sn = $(this).data 'sn'
			$(this).snLayout('load', ('div':'main', 'file':'main.html'))
			$(this).snLayout('load', ('div':'header', 'file':'header.html'))
			$(this).snLayout('load', ('div':'content', 'file':'content.html'))
			$('.bar-caption').html sn.region.caption

		load: (options = {}) ->
			sn = $(this).data 'sn'
			def =
				'div':'main'
				'file':'main.html'

			$.extend def, options
			$.ajax
				url: 'layout/' + sn.region.name + '/' + def.file
				async: false
				dataType: 'html'
				success: (s) ->
					$('#'+def.div).html s

	$.fn.snLayout = (sn = {}) ->
		if methods[sn]
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			if typeof sn == 'object' || !sn
				methods.init.apply @, arguments
			else 
				$.error 'Метод ' + sn + ' не существует'

