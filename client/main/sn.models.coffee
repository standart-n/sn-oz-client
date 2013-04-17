$ ->

	methods =
		init: (options = {}) ->

		main: (options = {}) ->
			_this = this
			sn = $(this).data 'sn'
			def =
				elem: '#main'
				type: 'main'
				text: ''
			$.extend def, options
			$(def.elem).html def.text

		primary: (options = {}) ->

			_this = this
			sn = $(this).data 'sn'
			def =
				elem: '#primary-content'
				type: 'primary'
			$.extend def, options
			
			if def.file?
				$(this).snModels 'load', def, (s) ->
					$(def.elem).html $(_this).snWiki('primary', text: s)
					$(_this).snTriggers 'spoiler'
			else
				if def.text?
					$(def.elem).html $(_this).snWiki('primary', text: def.text)
					$(_this).snTriggers 'spoiler'


		side: (options = {}) ->		

			_this = this
			sn = $(this).data 'sn'
			def =
				elem: '#side-content'
				type: 'side'
			$.extend def, options
			
			if def.file?
				$(this).snModels 'load', def, (s) ->
					$(def.elem).html $(_this).snWiki('side', text: s)
			else
				if def.text?
					$(def.elem).html $(_this).snWiki('side', text: def.text)

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

			$.ajax
				url: def.url
				async: off
				cache: off
				dataType: 'html'
				success: (text) ->
					if text?
						callback(text) if callback



	$.fn.snModels = (sn = {}) ->
		if methods[sn]
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			if typeof sn == 'object' || !sn
				methods.init.apply @, arguments
			else 
				$.error 'Метод ' + sn + ' не существует'
