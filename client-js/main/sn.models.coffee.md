Загрузка моделей
----------------

	$ ->

		methods =

по-умолчанию, загруказ в #main

			init: (options = {}) ->
				def =
					elem:		'#main'
					type:		'main'
					wiki:		off
				$.extend def, options

				$(this).snModels 'append', def

загрузка в блок #primary

			primary: (options = {}) ->

				console.log 'models: ' + 'primary' if console?

				def =
					elem:		'#primary'
					type:		'primary'
					wiki:		on
				$.extend def, options
				
				$(this).snModels 'append', def

загрузка в #side

			side: (options = {}) ->		

				console.log 'models: ' + 'side' if console?

				def =
					elem:		'#side'
					type:		'side'
					wiki:		on
				$.extend def, options
				
				$(this).snModels 'append', def


скрипт загрузки, который извлекается текст,
передает его методу inner, а затем запускает необходимые триггеры

			append: (def = {}) ->

				_this = this
				sn = $(this).data 'sn'

если нужно зарузить файл

				if def.file?
					$(this).snModels 'load', def, (s) ->
						def.text = s
						$(_this).snModels 'inner', def
						$(_this).snTriggers 'spoiler' if def.type is 'primary'

если в параметре передается текст

				else
					if def.text?
						$(_this).snModels 'inner', def
						$(_this).snTriggers 'spoiler' if def.type is 'primary'


если в параметре передается путь к представлению
загружаем спомощью EJS

					else
						if def.view?
							def.text = new EJS(url: 'view/' + def.view, ext: '.html').render(sn)
							$(_this).snModels 'inner', def
							$(_this).snTriggers 'spoiler' if def.type is 'primary'

если в параметре передается путь к шаблону
загружаем спомощью EJS

						else
							if def.layout?
								def.text = new EJS(url: 'layout/' + sn.region.name + '/' + def.layout , ext: '.html').render(sn)
								$(_this).snModels 'inner', def
								$(_this).snTriggers 'spoiler' if def.type is 'primary'

вставка текста

			inner: (options = {}) ->

параметры по умолчанию

				def =
					elem: 		'#side-content'
					type: 		'side'
					text: 		''
					wiki:		on
					position: 	'place'
				$.extend def, options

вывод в логи

				console.log 'innerText: ' + def.type + ' ' + def.position if console?
				
обрабатываем вики-разметку

				def.text = $(this).snWiki(def.type, text: def.text) if def.wiki is on
		
вставляем текст в нудный блок

				switch def.position
					when 'place'
						$(def.elem).html def.text
					when 'after'
						$(def.elem).html $(def.elem).html() + def.text
					when 'before'
						$(def.elem).html def.text + $(def.elem).html()

запускаем необходимые триггеры для корректного отображения контента,
который мы вставили

				$(this).snTriggers 'plugins', def


скрипт для загрузки текста из файла

			load: (options = {},callback) ->

параметры по-умолчанию

				sn = $(this).data 'sn'
				def =
					url: ''
					type: 'view'
					file: 'news.html'
				$.extend def, options

определяем нужный путь к файлу

				switch def.type
					when 'view'
						def.url = 'view/' + def.file
					when 'layout'
						def.url = 'layout/' + sn.region.name + '/' + def.file
					when 'primary'
						def.url = 'content/' + sn.region.name + '/' + def.file
					when 'side'
						def.url = 'content/' + sn.region.name + '/side_' + def.file

запись в логи
				
				console.log 'type: ' + def.type if console?
				console.log 'file: ' + def.file if console?
				console.log 'url: ' + def.url if console?

берем текст спомощью ajax

				$.ajax
					url: def.url
					async: off
					cache: off
					dataType: 'html'
					success: (text) ->
						if text?
							console.log 'success' if console?
							callback(text) if callback

инициализация

		$.fn.snModels = (sn = {}) ->
			if methods[sn]
				methods[sn].apply @, Array.prototype.slice.call arguments, 1
			else 
				methods.init.apply @, arguments
