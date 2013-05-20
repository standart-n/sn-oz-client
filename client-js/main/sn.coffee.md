
Старт приложения
----------------

```coffeescript

	$ ->
		methods =
			init: (options = {}) ->

```

начальное состояние объекта sn
```coffeescript

				sn =
					levels:{} # состояние последнего перехода
					users:{} # состояние пользователя
					content:{}
					result:{} # результат последнего ajax запроса
					theme:{} # тема оформления
					settings:{} # доп. настройки


				$.extend true, sn, options
				$(this).data 'sn', sn

```

загрузка конфигов
```coffeescript

				console.log 'configuration...' if console?
				$(this).snConf()

```

загрузка оболочки и дизайна
```coffeescript

				console.log 'layout...' if console?
				$(this).snLayout()

```

отображение начальной страницы по событию #autoload
```coffeescript

				console.log 'autoload...' if console?
				$(this).snEvents '#autoload'

```

инициализация 
```coffeescript

		$.fn.sn = (sn = {}) ->
			if methods[sn]
				methods[sn].apply @, Array.prototype.slice.call arguments, 1
			else 
				methods.init.apply @, arguments

```
