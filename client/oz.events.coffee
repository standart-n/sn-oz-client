$ ->

	methods =
		init: (options = {}) ->
			def =
				'href':'none'

			$.extend true, def, options
			
			sn = $(this).data 'oz'
			href = def.href + '/:'
			l_one = href.replace /(.*)#(.*?)\/(.*)/, '$2'

			switch l_one
				when 'autoload'
					$(this).ozModels('primary', 'file':'main.html')
					$(this).ozModels('side', 'file':'main.html')
					$(this).ozTriggers('switchSide', 'link':'main')
					$(this).ozTriggers('linksBar')
					$(this).ozTriggers('linksSide')
					$(this).ozTriggers('linksPrimary')
					$(this).ozTriggers('switcherBar')
					$(this).ozTriggers('switcherSide')
					sn.part = 'main'

				else
					l_two = href.replace /(.*)#(.*?)\/(.*?)\/(.*)/, '$3'
					$('html,body').animate scrollTop:0, 0
					if l_one != sn.part
						$(this).ozTriggers('switchBar', 'link':l_one)
						$(this).ozModels('side', 'file':l_one + '.html')
						$(this).ozTriggers('linksSide')
						$(this).ozTriggers('switcherSide')
						sn.part = l_one

					switch l_two
						when 'text'
							l_three = href.replace /(.*)#(.*?)\/(.*?)\/(.*?)\/(.*)/, '$4'
							$(this).ozTriggers('switchSide', 'link':l_three)
							$(this).ozModels('primary', 'file':l_three + '.html')

						when 'signin'
							$(this).ozTriggers('switchSide', 'link':'signin')
							$(this).ozModels('primary', 'file':'signin.html')
							$(this).ozSignin()

						when 'registration'
							$(this).ozTriggers('switchSide', 'link':'registration')
							$(this).ozModels('primary', 'file':'registration.html')
							$(this).ozSignin()

						when 'horoscope'
							$(this).ozTriggers('switchSide', 'link':'horoscope')
							$(this).ozModels('primary', 'file':'horoscope.html')								
							$(this).ozHoroscope()

			$(this).data 'oz', sn
			anchor = href.replace /(.*)\:(.*?)\/(.*)/, '$2'
			if anchor != ''
				if $('#anchor-' + anchor).length
					height = $('#anchor-' + anchor).offset().top-87
					if height
						if  $('#side-' + anchor).length
							$(this).ozTriggers 'switchSide', 'link':anchor
						$('html,body').animate  scrollTop:height, 'slow'


	$.fn.ozEvents = (sn = {}) ->
		if methods[sn]
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			if typeof sn == 'object' || !sn
				methods.init.apply @, arguments
			else 
				$.error 'Метод ' + sn + ' не существует'
