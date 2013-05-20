Загрузка настроек
```coffeescript

	$ ->
		methods =

```

автозагрузка
```coffeescript
			
			init: (options = {}) ->
				$(this).snConf 'main'
				$(this).snConf 'theme'
				$(this).snConf 'css'
				$(this).snConf 'js'
				$(this).snConf 'settings'

```

загрузка главного конфига, 
в нем хранится информация о том какой регион и какую тему оформления нужно загрузить
```coffeescript

			main: ->

				sn = $(this).data 'sn'
				console.log 'conf: ' + 'main.json' if console?

				$.ajax
					url: 'conf/main.json'
					async: off
					dataType: 'json'
					success: (s) ->
						$.extend sn, s
						$(this).data 'sn', sn

```

загрузка информации о нужной теме оформления
```coffeescript

			theme: ->

				sn = $(this).data 'sn'
				console.log 'conf: ' + 'themes.json' if console?

				$.ajax
					url: 'conf/themes.json'
					async: off
					dataType: 'json'
					success: (s) ->
						if s[sn.theme.name]
							$.extend sn.theme, s[sn.theme.name]
							sn.theme.enable = on
						else
							sn.theme.enable = off
						
						$(this).data 'sn', sn

```

загрузка css файлов для данной темы оформления, если они прописаны в theme.json
а не загружаются сразу в index.html
```coffeescript

			css: ->

				sn = $(this).data 'sn'
				console.log 'conf: ' + 'css' if console?

				if sn.theme.css
					$.each sn.theme.css, (i) ->
						head = document.getElementsByTagName('head')[0]
						link = document.createElement 'link'
						link.rel = 'stylesheet'
						link.type = 'text/css'
						link.href = this
						head.appendChild link

```

ajax загрузка необходимых скриптов для данной темы
```coffeescript

			js: ->

				sn = $(this).data 'sn'
				console.log 'conf: ' + 'js' if console?

				if sn.theme.js
					$.each sn.theme.js, (i) ->
						$.getScript @

другие настройки
```coffeescript

			settings: ->

				sn = $(this).data 'sn'
				console.log 'conf: ' + 'settings.json' if console?

				$.ajax
					url: 'conf/settings.json'
					async: off
					dataType: 'json'
					success: (s) ->
						if s?
							$.extend sn.settings, s
							sn.settings.enable = on
						
						$(this).data 'sn', sn

```

инициализация
```coffeescript

		$.fn.snConf = (sn = {}) ->
			if methods[sn]
				methods[sn].apply @, Array.prototype.slice.call arguments, 1
			else 
				methods.init.apply @, arguments

```