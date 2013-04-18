$ ->

	methods =
		init: (options = {}) ->

		main: (options = {}) ->

			console.log 'models: ' + 'main'

			_this = this
			sn = $(this).data 'sn'
			def =
				elem: '#main'
				type: 'main'
				text: ''
			$.extend def, options
			$(def.elem).html def.text

		primary: (options = {}) ->

			console.log 'models: ' + 'primary'

			_this = this
			sn = $(this).data 'sn'
			def =
				elem: '#primary-content'
				type: 'primary'
			$.extend def, options
			
			if def.file?
				$(this).snModels 'load', def, (s) ->
					def.text = s
					$(_this).snModels 'inner', def
					$(_this).snTriggers 'spoiler'
			else
				if def.text?
					$(_this).snModels 'inner', def
					$(_this).snTriggers 'spoiler'


		side: (options = {}) ->		

			console.log 'models: ' + 'side'

			_this = this
			sn = $(this).data 'sn'
			def =
				elem: '#side-content'
				type: 'side'
			$.extend def, options
			
			if def.file?
				$(this).snModels 'load', def, (s) ->
					def.text = s
					$(_this).snModels 'inner', def
			else
				if def.text?
					$(_this).snModels 'inner', def

		inner: (options = {}) ->

			sn = $(this).data 'sn'
			def =
				elem: 		'#side-content'
				type: 		'side'
				text: 		''
				position: 	'place'
			$.extend def, options

			console.log 'innerText: ' + def.type + ' ' + def.position

			switch def.position
				when 'place'
					$(def.elem).html $(this).snWiki(def.type, text: def.text)
				when 'after'
					$(def.elem).html $(def.elem).html() + $(this).snWiki(def.type, text: def.text)
				when 'before'
					$(def.elem).html $(this).snWiki(def.type, text: def.text) + $(def.elem).html()


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
				when 'primary'
					def.url = 'content/' + sn.region.name + '/' + def.file
				when 'side'
					def.url = 'content/' + sn.region.name + '/side_' + def.file

			console.log 'type: ' + def.type
			console.log 'file: ' + def.file
			console.log 'url: ' + def.url

			$.ajax
				url: def.url
				async: off
				cache: off
				dataType: 'html'
				success: (text) ->
					if text?
						console.log 'success'
						callback(text) if callback



	$.fn.snModels = (sn = {}) ->
		if methods[sn]
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			if typeof sn == 'object' || !sn
				methods.init.apply @, arguments
			else 
				$.error 'Метод ' + sn + ' не существует'
