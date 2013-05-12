
$ ->

	methods =
		init: (options = {}) ->
			def =
				href:'none'

			if typeof sn isnt 'object'
				def.href = options
			else				
				$.extend true, def, options
			
			if def.href isnt '#' and def.href.match(/#(.*)/)
				
				sn = $(this).data 'sn'	
				sn.href = def.href + '/:'
				sn.levels =
					one: sn.href.replace /(.*)#(.*?)\/(.*)/, '$2'
					two: sn.href.replace /(.*)#(.*?)\/(.*?)\/(.*)/, '$3'
					three: sn.href.replace /(.*)#(.*?)\/(.*?)\/(.*?)\/(.*)/, '$4'
					anchor: sn.href.replace /(.*)\:(.*?)\/(.*)/, '$2'

				console.info 'url: ' + sn.href if console?
				console.info 'levels: ', sn.levels if console?

				if sn.levels.one? and sn.levels.one isnt 'spoiler'
					switch sn.levels.one
						when 'autoload'
							$(this).snModels 'primary', file: 'main.html'
							$(this).snModels 'side', file: 'main.html'
							$(this).snTriggers 'switch', 'side', 'main'
							$(this).snTriggers 'links', 'bar'
							$(this).snTriggers 'links', 'side'
							$(this).snTriggers 'links', 'primary'
							$(this).snTriggers 'hover', 'bar'
							(this).snTriggers 'hover', 'side'
							sn.part = 'main'

						else
							
							if sn.levels.two? and sn.levels.three?

								$('html,body').animate scrollTop:0, 0
								
								if sn.levels.two is 'text'
									if sn.levels.one isnt sn.part
										$(this).snModels 'side', file: sn.levels.one + '.html'
										$(this).snModels 'primary', file: sn.levels.three + '.html'
										$(this).snTriggers 'links', 'side'
										$(this).snTriggers 'links', 'primary'
										$(this).snTriggers 'switch', 'bar', sn.levels.one
										$(this).snTriggers 'switch', 'side', sn.levels.three
										$(this).snTriggers 'hover', 'side'
									else
										$(this).snModels 'primary', file: sn.levels.three + '.html'
										$(this).snTriggers 'links', 'primary'
										$(this).snTriggers 'switch', 'side', sn.levels.three

					sn.part = sn.levels.one
					$(this).data 'sn', sn
					$(this).snEvents 'anchor'
					$(this).click()

		anchor: (options = {}) ->
			sn = $(this).data 'sn'
			if sn.levels.anchor isnt ''
				try
					if $('#anchor-' + sn.levels.anchor).length
						height = $('#anchor-' + sn.levels.anchor).offset().top-87
						if height
							if  $('#side-' + sn.levels.anchor).length
								$(this).snTriggers 'switchSide', 'link':sn.levels.anchor
							$('html,body').animate  scrollTop:height, 'slow'
				catch e
					console.error 'anchor', e if console?



	$.fn.snEvents = (sn = {}) ->
		if methods[sn]
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			methods.init.apply @, arguments
			