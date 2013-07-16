
# Загрузка моделей

require('jquery')
require('ejs')

$ ->

	class window.snModels

		constructor: (@options = {}) ->

		# по-умолчанию, загруказ в #main

		get: (elem = '#main', options = {}) ->

			console.log 'models into ' + elem

			def =
				wiki:		on
			$.extend def, options

			def.elem = elem

			@append def



		append: (def = {}) ->

		# если нужно зарузить файл

			if def.file?
				@load def.file, (s) =>
					def.text = s
					@inner def

			# если в параметре передается текст

			else
				if def.text?
					@inner def


				# если в параметре передается путь к представлению
				# загружаем спомощью EJS

				else
					if def.view?
						if window.EJS?
							def.text = new EJS(url: 'view/' + def.view, ext: '.html').render(window.sn)
							@inner def

					# если в параметре передается путь к шаблону
					# загружаем спомощью EJS

					else
						if def.layout?
							if window.EJS?
								def.text = new EJS(url: 'layout/' + window.sn.region.name + '/' + def.layout , ext: '.html').render(window.sn)
								@inner def

		# вставка текста

		inner: (options = {}) ->

			# параметры по умолчанию

			def =
				elem:		'#main'
				wiki:		on
				position: 	'place'
			$.extend def, options

			if def.text?

				# вывод в логи

				console.log 'innerText'
				
				# обрабатываем вики-разметку

				if def.wiki is on and window.wiki?
					def.text = window.wiki.render(def.text)
		
				# вставляем текст в нужный блок

				switch def.position
					when 'place'
						$(def.elem).html def.text
					when 'after'
						$(def.elem).html $(def.elem).html() + def.text
					when 'before'
						$(def.elem).html def.text + $(def.elem).html()

		# скрипт для загрузки текста из файла

		load: (file, callback) ->

			# параметры по-умолчанию

			if file?

				url = 'content/' + window.sn.region.name + '/' + file

				# запись в логи
				
				console.log 'file: ' + file

				# берем текст спомощью ajax

				$.ajax
					url: url
					async: off
					cache: off
					dataType: 'html'
					success: (text) ->
						if text?
							console.log 'success'
							callback(text) if callback

