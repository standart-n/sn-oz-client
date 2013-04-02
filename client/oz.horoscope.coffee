$ ->

	methods =
		init: (options = {}) ->
			
			def =
				'el':'#primary-content'
			
			$.extend true, def, options
			sn = $(this).data 'oz'
			
			$.ajax
				url: 'http://oz.st-n.ru/horoscope/?callback=?'
				dataType: 'jsonp'
				success: (s) ->
					if s.hscope
						$.each s.hscope, (key, value) ->
							if value.description
								$('#hscope-description-'+key).html value.description

	$.fn.ozHoroscope = (sn = {}) ->
		if methods[sn]
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			if typeof sn == 'object' || !sn
				methods.init.apply @, arguments
			else 
				$.error 'Метод ' + sn + ' не существует'
