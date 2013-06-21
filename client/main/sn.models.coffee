
###
Загрузка моделей
----------------
###

$ ->

	methods =

		# по-умолчанию, загруказ в #main

		init: (elem = '#main', options = {}) ->

			console.log 'models into ' + elem if console?

			def =
				wiki:		on
			$.extend def, options

			def.elem = elem

			$(this).snModels 'append', def



		append: (def = {}) ->

			_this = this

		# если нужно зарузить файл

			if def.file?
				$(this).snModels 'load', def.file, (s) ->
					def.text = s
					$(_this).snModels 'inner', def

			# если в параметре передается текст

			else
				if def.text?
					$(_this).snModels 'inner', def


				# если в параметре передается путь к представлению
				# загружаем спомощью EJS

				else
					if def.view?
						if window.EJS?
							def.text = new EJS(url: 'view/' + def.view, ext: '.html').render(window.sn)
							$(_this).snModels 'inner', def

					# если в параметре передается путь к шаблону
					# загружаем спомощью EJS

					else
						if def.layout?
							if window.EJS?
								def.text = new EJS(url: 'layout/' + window.sn.region.name + '/' + def.layout , ext: '.html').render(window.sn)
								$(_this).snModels 'inner', def

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

				console.log 'innerText' if console?
				
				# обрабатываем вики-разметку

				if def.wiki is on and window.sn.wiki?
					def.text = $(this).snWiki(def.text) 
		
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
				
				console.log 'file: ' + file if console?

				# берем текст спомощью ajax

				$.ajax
					url: url
					async: off
					cache: off
					dataType: 'html'
					success: (text) ->
						if text?
							console.log 'success' if console?
							callback(text) if callback

	# инициализация

	$.fn.snModels = (sn = {}) ->
		if methods[sn]
			methods[sn].apply @, Array.prototype.slice.call arguments, 1
		else 
			methods.init.apply @, arguments
