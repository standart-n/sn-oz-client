$ ->

	methods = 
		init: (options = {}) ->
			sn = $(this).data 'oz'
			$(this).ozLayout('load', ('div':'main', 'file':'main.html'))
			$(this).ozLayout('load', ('div':'header', 'file':'header.html'))
			$(this).ozLayout('load', ('div':'content', 'file':'content.html'))
			$('.bar-caption').html sn.region.caption

		load: (options = {}) ->
			sn = $(this).data 'oz'
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

	$.fn.ozLayout = (sn = {}) ->
		if methods[sn]
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			if typeof sn == 'object' || !sn
				methods.init.apply @, arguments
			else 
				$.error 'Метод ' + sn + ' не существует'

