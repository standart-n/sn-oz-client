$ ->

	methods =
		init: (options = {}) ->

		primary: (options = {}) ->

			sn = $(this).data 'oz'
			oz = $(this)
			def =
				'file':'main.html'

			$.extend def, options
			
			$.ajax
				url: 'content/' + sn.region.name + '/' + def.file
				async: false
				cache: false
				dataType: 'html'
				success: (text) ->
					text = oz.ozWiki('tags', 'text':text)
					text = oz.ozWiki('formating', 'text':text)
					text = oz.ozWiki('headings', 'text':text)
					text = oz.ozWiki('externalLinks', 'text':text)
					text = oz.ozWiki('fileLinks', 'text':text)
					text = oz.ozWiki('internalLinks', 'text':text)
					text = oz.ozWiki('mailTo', 'text':text)
					text = oz.ozWiki('photo', 'text':text)
					text = oz.ozWiki('image', 'text':text)
					text = oz.ozWiki('fonts', 'text':text)
					text = oz.ozWiki('anchor', 'text':text)
					text = oz.ozWiki('indPrimary', 'text':text)
					text = oz.ozWiki('spoiler', 'text':text)
					text = oz.ozWiki('spaces', 'text':text)

					$('#primary-content').html text 
					oz.ozTriggers 'spoiler'

		side: (options = {}) ->		
			sn = $(this).data 'oz'
			oz = $(this)
			def =
				'file':'news.html'

			$.extend def, options
			
			$.ajax
				url: 'content/' + sn.region.name + '/side_' + def.file
				async: false
				cache: false
				dataType: 'html'
				success: (text) ->
					text = oz.ozWiki('tags', 'text':text)
					text = oz.ozWiki('formating', 'text':text)
					text = oz.ozWiki('headings', 'text':text)
					text = oz.ozWiki('externalLinks', 'text':text)
					text = oz.ozWiki('fileLinks', 'text':text)
					text = oz.ozWiki('internalLinks', 'text':text)
					text = oz.ozWiki('mailTo', 'text':text)
					text = oz.ozWiki('photo', 'text':text)
					text = oz.ozWiki('image', 'text':text)
					text = oz.ozWiki('fonts', 'text':text)
					text = oz.ozWiki('anchor', 'text':text)
					text = oz.ozWiki('gismeteo', 'text':text)
					text = oz.ozWiki('indSide', 'text':text)
					text = oz.ozWiki('sideMenu', 'text':text)
					text = oz.ozWiki('spaces', 'text':text)
					
					$('#side-content').html text
					# alert("!"+text+"!")


	$.fn.ozModels = (sn = {}) ->
		if methods[sn]
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			if typeof sn == 'object' || !sn
				methods.init.apply @, arguments
			else 
				$.error 'Метод ' + sn + ' не существует'
