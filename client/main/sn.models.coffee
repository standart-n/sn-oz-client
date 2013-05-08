$ ->

	methods =
		init: (options = {}) ->
			def =
				elem:		'#main'
				type:		'main'
				wiki:		off
			$.extend def, options

			$(this).snModels 'append', def

		primary: (options = {}) ->

			console.log 'models: ' + 'primary' if console?

			def =
				elem:		'#primary'
				type:		'primary'
				wiki:		on
			$.extend def, options
			
			$(this).snModels 'append', def



		side: (options = {}) ->		

			console.log 'models: ' + 'side' if console?

			def =
				elem:		'#side'
				type:		'side'
				wiki:		on
			$.extend def, options
			
			$(this).snModels 'append', def


		append: (def = {}) ->

			_this = this
			sn = $(this).data 'sn'

			if def.file?
				$(this).snModels 'load', def, (s) ->
					def.text = s
					$(_this).snModels 'inner', def
					$(_this).snTriggers 'spoiler' if def.type is 'primary'
			else
				if def.text?
					$(_this).snModels 'inner', def
					$(_this).snTriggers 'spoiler' if def.type is 'primary'
				else
					if def.view?
						def.text = new EJS(url: 'view/' + def.view, ext: '.html').render(sn)
						$(_this).snModels 'inner', def
						$(_this).snTriggers 'spoiler' if def.type is 'primary'
					else
						if def.layout?
							def.text = new EJS(url: 'layout/' + sn.region.name + '/' + def.layout , ext: '.html').render(sn)
							$(_this).snModels 'inner', def
							$(_this).snTriggers 'spoiler' if def.type is 'primary'


		inner: (options = {}) ->

			def =
				elem: 		'#side-content'
				type: 		'side'
				text: 		''
				wiki:		on
				position: 	'place'
			$.extend def, options

			console.log 'innerText: ' + def.type + ' ' + def.position if console?
			
			def.text = $(this).snWiki(def.type, text: def.text) if def.wiki is on
	
			switch def.position
				when 'place'
					$(def.elem).html def.text
				when 'after'
					$(def.elem).html $(def.elem).html() + def.text
				when 'before'
					$(def.elem).html def.text + $(def.elem).html()

			$(this).snTriggers 'plugins', def



		load: (options = {},callback) ->


			sn = $(this).data 'sn'
			def =
				url: ''
				type: 'view'
				file: 'news.html'
			$.extend def, options

			switch def.type
				when 'view'
					def.url = 'view/' + def.file
				when 'layout'
					def.url = 'layout/' + sn.region.name + '/' + def.file
				when 'primary'
					def.url = 'content/' + sn.region.name + '/' + def.file
				when 'side'
					def.url = 'content/' + sn.region.name + '/side_' + def.file

			console.log 'type: ' + def.type if console?
			console.log 'file: ' + def.file if console?
			console.log 'url: ' + def.url if console?

			$.ajax
				url: def.url
				async: off
				cache: off
				dataType: 'html'
				success: (text) ->
					if text?
						console.log 'success' if console?
						callback(text) if callback



	$.fn.snModels = (sn = {}) ->
		if methods[sn]
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			methods.init.apply @, arguments
