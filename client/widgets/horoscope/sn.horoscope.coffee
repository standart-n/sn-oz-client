$ ->

	methods =
		init: (options = {}) ->
			_this = this
			$(this).on 'click',() ->
				sn = $(_this).data 'sn'
				if sn.levels.two is 'horoscope'
					alert 'horoscope'

		
		load: () ->	
			def =
				'el':'#primary-content'
			
			$.extend true, def, options
			sn = $(this).data 'sn'
			
			$.ajax
				url: 'http://oz.st-n.ru/horoscope/?callback=?'
				dataType: 'jsonp'
				success: (s) ->
					if s.hscope
						$.each s.hscope, (key, value) ->
							if value.description
								$('#hscope-description-'+key).html value.description

	$.fn.snHoroscope = (sn = {}) ->
		if methods[sn]
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			methods.init.apply @, arguments

	# $('#sn').snHoroscope()

