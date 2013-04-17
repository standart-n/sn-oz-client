$ ->

	methods =
		init: (options = {}) ->

		primary: (options = {}) ->

			_this = this
			sn = $(this).data 'sn'
			def =
				'elem':'#primary-content'
				'type':'primary'
				'file':'main.html'
			$.extend def, options
			
			$(this).snModels 'load', def, (text) ->
				$(def.elem).html $(_this).snWiki('primary', 'text':text)
				$(_this).snTriggers 'spoiler'

		side: (options = {}) ->		

			_this = this
			sn = $(this).data 'sn'
			def =
				'elem':'#side-content'
				'type':'side'
				'file':'news.html'
			$.extend def, options
			
			$(this).snModels 'load', def, (text) ->
				$(def.elem).html $(_this).snWiki('side', 'text':text)

		load: (options = {},callback) ->
			sn = $(this).data 'sn'
			def =
				'url':''
				'type':'view'
				'file':'news.html'
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
				async: false
				cache: false
				dataType: 'html'
				success: (text) ->
					callback(text) if callback



	$.fn.snModels = (sn = {}) ->
		if methods[sn]
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			if typeof sn == 'object' || !sn
				methods.init.apply @, arguments
			else 
				$.error 'Метод ' + sn + ' не существует'
